# 项目文档

本文档遵循上下文工程规范组织开发工作。

## 目录结构

- **static/** - 静态文档（长期维护）
  - architecture/ - 系统架构
  - design/ - 模块设计
  - api/ - 接口文档
  - guide/ - 使用指南
  - spec/ - 需求规格

- **contexts/** - 开发上下文（按时间+功能组织）
  - 使用 `/context-engineering` 技能管理

- **archive/** - 归档文档（已完成需求）

## 工作流程

1. **开始新需求**：使用 context-manager agent
2. **查看活跃上下文**：查看活跃上下文
3. **归档已完成**：归档 [contextId]

## 相关命令

- `/context-engineering` - 上下文管理
- `/serena-mcp` - Serena MCP 工具
- `/project-init` - 项目初始化

## 权限配置

项目已配置优化的权限规则：

**自动允许**：
- 文档编辑：`*.md`, `*.txt`
- 项目内读取：`./**/*`
- 搜索工具：`Grep`, `Glob`
- Bash 命令：`grep`, `cat`, `ls`, `find`, `head`, `tail`, `tree`

**需要询问**：
- 读取项目外文件：`/Users/**/*`, `~/**/*`

## Serena MCP

Serena MCP 已激活，提供：
- LSP 符号级代码导航
- 符号搜索和引用查找
- 智能重构工具
- 项目记忆和上下文延续

## 快速开始

1. 使用 `/context-engineering` 开始新需求
2. 使用 `/serena-mcp` 访问符号级代码工具
3. 使用 `/checkpoint` 管理开发检查点
