# Context Engineering - 上下文工程文档管理

## 核心原则

本项目使用上下文工程文档管理系统，用于组织开发过程中的文档。

## 目录结构

- **静态文档**: `docs/static/` - 长期维护的架构、API 文档
- **开发上下文**: `docs/contexts/` - 按时间+功能组织的需求、计划

## 使用方法

### 查看活跃上下文
读取 `docs/contexts/.contexts-index.json` 查看当前活跃的开发任务。

### 上下文管理
需要进行上下文管理时，使用 **context-manager** agent：
- 开始新需求：`开始新需求：[功能名称]`
- 归档需求：`归档 [contextId]`

## 详细规范

完整的规范、模板和最佳实践请参考：
- **规范文档**: `docs/static/development/context-engineering-spec.md`
- **文档模板**: `docs/static/development/context-engineering-templates.md`

## 工作流程

1. 开始新需求时，使用 context-manager agent 初始化上下文
2. 开发过程中，将文档写入对应的上下文目录
3. 完成需求后，使用 context-manager agent 归档
