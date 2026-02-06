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

## 职位模板增强工具

### 概述
项目包含 `position-enhancer` 工具,用于增强职位模板的详细程度,使字数从300-400字增加到600-800字。

### 快速使用
```bash
/position-enhancer
```

### 详细文档
- **使用指南**: [position-enhancer-guide.md](position-enhancer-guide.md)
- **实施总结**: [position-enhancer-implementation.md](position-enhancer-implementation.md)

### 当前状态
| 职位模板 | 当前字数 | 状态 |
|---------|---------|------|
| test-engineer.md | 339字 | ❌ 需要增强 |
| test-engineer-enhanced.md | 601字 | ✅ 增强示例 |

### 增强效果
- **更好的AI理解**: 详细的描述让AI更准确理解职位职责
- **更准确的执行**: 明确的流程和标准让AI执行更符合预期
- **更好的协作**: 详细的协作接口说明让跨角色协作更顺畅
- **更清晰的标准**: 明确的交付标准和验证命令让质量可控
