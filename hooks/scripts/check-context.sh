#!/bin/bash
# check-context.sh - PostToolUse hook to monitor context usage and trigger smart compaction
set -euo pipefail

# Read hook input
input=$(cat)

# Get project directory
project_dir="${CLAUDE_PROJECT_DIR:-.}"

# Read configuration
config_file="$project_dir/.claude/session-memory.local.md"
context_warning_threshold=70
context_urgent_threshold=80
context_critical_threshold=90
auto_compact_threshold=70  # 自动压缩阈值

if [ -f "$config_file" ]; then
  context_warning_threshold=$(grep -A 30 "^---$" "$config_file" | grep "contextWarningThreshold:" | awk '{print $2}' || echo "70")
  context_urgent_threshold=$(grep -A 30 "^---$" "$config_file" | grep "contextUrgentThreshold:" | awk '{print $2}' || echo "80")
  context_critical_threshold=$(grep -A 30 "^---$" "$config_file" | grep "contextCriticalThreshold:" | awk '{print $2}' || echo "90")
  auto_compact_threshold=$(grep -A 30 "^---$" "$config_file" | grep "autoCompactThreshold:" | awk '{print $2}' || echo "70")
fi

# 尝试从 hook input 中获取上下文使用率
# Claude Code 的 PostToolUse hook 可能在 input 中提供上下文信息
context_usage=$(echo "$input" | jq -r '.contextUsage // 0' 2>/dev/null || echo "0")

# 如果 hook input 中没有，尝试从环境变量获取
if [ "$context_usage" -eq 0 ] && [ -n "${CLAUDE_CONTEXT_USAGE:-}" ]; then
  context_usage="$CLAUDE_CONTEXT_USAGE"
fi

# 如果还是没有，尝试读取状态文件
if [ "$context_usage" -eq 0 ] && [ -f "$project_dir/.claude/context-usage" ]; then
  context_usage=$(cat "$project_dir/.claude/context-usage" 2>/dev/null || echo "0")
fi

# 如果无法获取实际使用率，暂时跳过
if [ "$context_usage" -eq 0 ]; then
  echo '{"continue": true, "suppressOutput": true}'
  exit 0
fi

# Determine warning level and message
level="none"
icon=""
message=""
should_compact=false

if [ "$context_usage" -ge "$context_critical_threshold" ]; then
  level="critical"
  icon="🚨"
  message="上下文使用率: ${context_usage}% | 立即执行智能压缩"
  should_compact=true
elif [ "$context_usage" -ge "$context_urgent_threshold" ]; then
  level="urgent"
  icon="⚠️"
  message="上下文使用率: ${context_usage}% | 建议执行智能压缩"
  should_compact=true
elif [ "$context_usage" -ge "$context_warning_threshold" ]; then
  level="warning"
  icon="💡"
  message="上下文使用率: ${context_usage}% | 可以考虑智能压缩"
fi

# 如果达到自动压缩阈值，触发智能压缩
if [ "$context_usage" -ge "$auto_compact_threshold" ]; then
  should_compact=true
fi

# 输出警告消息
if [ "$level" != "none" ]; then
  # 如果达到自动压缩阈值，建议执行智能压缩
  if [ "$context_usage" -ge "$auto_compact_threshold" ]; then
    cat <<EOF
{
  "continue": true,
  "suppressOutput": false,
  "systemMessage": "$icon $message\\n\\n💡 建议操作：\\n1. 使用 Task 工具调用 smart-compact-agent 执行智能压缩\\n2. 或使用 /session-compact 命令一键压缩\\n\\n压缩后的记忆将保存到 .claude/session-memory.md.tmp",
  "notification": {
    "type": "warning",
    "title": "上下文使用率警告",
    "message": "使用率达${context_usage}%，建议执行智能压缩"
  }
}
EOF
  else
    cat <<EOF
{
  "continue": true,
  "suppressOutput": false,
  "systemMessage": "$icon $message"
}
EOF
  fi
else
  echo '{"continue": true, "suppressOutput": true}'
fi

exit 0
