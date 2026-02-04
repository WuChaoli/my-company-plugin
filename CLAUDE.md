# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**workflow-dev** is a development workspace for creating Claude Code workflow components including agents, plugins, and skills.

## Directory Structure

```
workflow-dev/
├── agents/     # Custom Claude Code agents
├── plugin/     # Claude Code plugin components
└── skills/     # Claude Code skills
```

## Component Types

### Agents (`agents/`)
Specialized subagents that handle specific tasks autonomously. Agents should include:
- Clear system prompts defining their purpose
- Tool access configuration
- Triggering conditions in descriptions
- YAML frontmatter with metadata

### Plugins (`plugin/`)
Plugin components that extend Claude Code functionality:
- Commands (slash commands with YAML frontmatter)
- Hooks (PreToolUse, PostToolUse, Stop events)
- MCP server integrations (.mcp.json)
- Plugin manifest (plugin.json)

### Skills (`skills/`)
Reusable knowledge modules and workflows:
- Progressive disclosure format
- Clear triggering conditions
- Examples and usage patterns
- Markdown-based content

## Development Workflow

### Creating New Components

1. **Agents**: Create `.md` files in `agents/` with YAML frontmatter
2. **Plugins**: Organize in `plugin/` with proper structure (commands/, agents/, skills/, hooks/)
3. **Skills**: Create `.md` files in `skills/` with clear descriptions

### Testing Components

Test components by:
- Copying to `~/.claude/agents/`, `~/.claude/plugins/`, or `~/.claude/skills/`
- Restarting Claude Code session
- Invoking with appropriate triggers or commands

### Best Practices

- Use descriptive names that indicate purpose
- Include comprehensive examples in documentation
- Define clear triggering conditions for agents and skills
- Test components in isolation before integration
- Follow Claude Code plugin development patterns

## Document Management

本项目使用上下文工程文档管理系统，遵循 `.claude/rules/context-engineering.md` 中定义的规范。

### 文档组织

- **静态文档**: `docs/static/` - 长期维护的架构、API 文档
- **开发上下文**: `docs/contexts/` - 按时间+功能组织的需求、计划

### 工作流程

1. **开始新需求**: 使用 context-manager agent 初始化上下文
2. **开发过程**: 将文档写入对应的上下文目录
3. **完成需求**: 使用 context-manager agent 归档

### 查看活跃上下文

读取 `docs/contexts/.contexts-index.json` 查看当前活跃的开发任务。

## Related Resources

- Plugin development: Use `/skill-creator` or plugin-dev skills
- Agent development: Reference `~/.claude/agents/` for examples
- Hook development: See `~/.claude/settings.json` for hook patterns
- Document management: See `.claude/rules/context-engineering.md`
