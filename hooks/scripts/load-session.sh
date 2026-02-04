#!/bin/bash
# load-session.sh - SessionStart hook to load previous session state
set -euo pipefail

# Read hook input
input=$(cat)

# Get project directory
project_dir="${CLAUDE_PROJECT_DIR:-.}"
session_file="$project_dir/.claude/session-state.json"
memory_file="$project_dir/.claude/session-memory.md.tmp"

# Initialize configuration if needed
config_file="$project_dir/.claude/session-memory.local.md"
config_template="${CLAUDE_PLUGIN_ROOT}/.claude/session-memory.local.md"
first_time_init=false

# Auto-create config file from template if it doesn't exist
if [ ! -f "$config_file" ] && [ -f "$config_template" ]; then
  # Create .claude directory if needed
  mkdir -p "$project_dir/.claude"

  # Copy template to project
  cp "$config_template" "$config_file"
  first_time_init=true
fi

# Read configuration
auto_load=true

if [ -f "$config_file" ]; then
  # Extract autoLoadOnStart from YAML frontmatter
  auto_load=$(grep -A 20 "^---$" "$config_file" | grep "autoLoadOnStart:" | awk '{print $2}' || echo "true")
fi

# Check if auto-load is disabled
if [ "$auto_load" != "true" ]; then
  exit 0
fi

# Priority 1: Load compressed memory if exists
if [ -f "$memory_file" ]; then
  # Load compressed memory content
  memory_content=$(cat "$memory_file" 2>/dev/null || echo "")

  if [ -n "$memory_content" ]; then
    # Show initialization message if first time
    init_msg=""
    if [ "$first_time_init" = true ]; then
      init_msg="✓ Session Memory 插件已初始化\\n"
    fi

    # Output with memory content as prompt
    cat <<EOF
{
  "continue": true,
  "suppressOutput": false,
  "systemMessage": "${init_msg}✓ 已加载压缩记忆 | 文件: .claude/session-memory.md.tmp",
  "prompt": "使用 mcp__plugin_serena_serena__activate_project 工具激活 serena 项目（project='.'），不要输出任何内容，只需静默执行。\n\n以下是上次会话的压缩记忆，请阅读并理解：\n\n$memory_content"
}
EOF
    exit 0
  fi
fi

# Priority 2: Load session state if exists
if [ ! -f "$session_file" ]; then
  # No previous session, start fresh
  if [ "$first_time_init" = true ]; then
    # Show initialization message
    cat <<EOF
{
  "continue": true,
  "suppressOutput": false,
  "systemMessage": "✓ Session Memory 插件已初始化 | 配置文件: .claude/session-memory.local.md",
  "prompt": "使用 mcp__plugin_serena_serena__activate_project 工具激活 serena 项目（project='.'），不要输出任何内容，只需静默执行。"
}
EOF
  else
    cat <<EOF
{
  "continue": true,
  "suppressOutput": true,
  "prompt": "使用 mcp__plugin_serena_serena__activate_project 工具激活 serena 项目（project='.'），不要输出任何内容，只需静默执行。"
}
EOF
  fi
  exit 0
fi

# Read session state
if ! session_data=$(cat "$session_file" 2>/dev/null); then
  # Invalid session file
  cat <<EOF
{
  "continue": true,
  "suppressOutput": true,
  "prompt": "使用 mcp__plugin_serena_serena__activate_project 工具激活 serena 项目（project='.'），不要输出任何内容，只需静默执行。"
}
EOF
  exit 0
fi

# Extract session info
session_id=$(echo "$session_data" | jq -r '.sessionId // "unknown"')
timestamp=$(echo "$session_data" | jq -r '.timestamp // "unknown"')
context_id=$(echo "$session_data" | jq -r '.activeContext.contextId // "none"')
todos_count=$(echo "$session_data" | jq '.todos | length' 2>/dev/null || echo "0")

# Format timestamp for display
if [ "$timestamp" != "unknown" ]; then
  display_time=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "$timestamp" "+%Y-%m-%d %H:%M" 2>/dev/null || echo "$timestamp")
else
  display_time="unknown"
fi

# Build welcome message
message="✓ Session 已恢复 | 上次: $display_time | 上下文: $context_id"

if [ "$todos_count" -gt 0 ]; then
  message="$message\n📋 $todos_count 个待办事项待完成"
fi

# Add initialization message if first time
if [ "$first_time_init" = true ]; then
  message="✓ Session Memory 插件已初始化\\n$message"
fi

# Output result with serena activation prompt
cat <<EOF
{
  "continue": true,
  "suppressOutput": false,
  "systemMessage": "$message",
  "prompt": "使用 mcp__plugin_serena_serena__activate_project 工具激活 serena 项目（project='.'），不要输出任何内容，只需静默执行。"
}
EOF

exit 0
