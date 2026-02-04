# 静态文档

本目录包含项目的长期维护文档，按功能模块组织。

## 目录结构

### architecture/
系统架构文档，包括：
- **system-context.md** - 系统上下文图
- **container.md** - 容器视图
- **component.md** - 组件视图
- **adr/** - 架构决策记录 (Architecture Decision Records)

### user-journey/
用户旅程和交互流程文档，按功能模块组织。

### data-flow/
数据流动和处理逻辑文档，按模块组织。

### api/
API 接口文档，按端点或模块组织。

## 维护规范

1. **更新时机**: 当架构、API 或核心流程发生变化时更新
2. **记录变更**: 在对应的上下文目录的 `.context.json` 中记录更新
3. **保持同步**: 确保文档与代码实现保持一致
4. **版本控制**: 所有文档纳入 Git 版本控制

## 文档格式

- 使用 Markdown 格式
- 使用 Mermaid 绘制图表
- 保持简洁清晰
- 包含必要的代码示例
