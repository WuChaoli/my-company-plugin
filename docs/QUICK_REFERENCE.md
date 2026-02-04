# 上下文工程系统 - 快速参考

## 常用命令

### 开始新需求
```
开始新需求：[功能名称]
```

### 查看活跃上下文
```
列出活跃上下文
```

### 切换上下文
```
切换到 [contextId]
```

### 归档上下文
```
归档 [contextId]
```

## 文档位置

### 静态文档（长期维护）
- 架构：`docs/static/architecture/`
- 用户旅程：`docs/static/user-journey/`
- 数据流：`docs/static/data-flow/`
- API：`docs/static/api/`

### 动态文档（按时间+功能）
- 上下文：`docs/contexts/YYYY-MM-DD_feature-name/`
- 索引：`docs/contexts/.contexts-index.json`

## 上下文文档结构

每个上下文包含：
- `.context.json` - 元数据
- `requirements.md` - 需求文档
- `architecture-changes.md` - 架构变更
- `feature-spec.md` - 功能规格
- `plan.md` - 实施计划
- `todos.md` - 任务清单
- `test-plan.md` - 测试计划
- `SUMMARY.md` - 归档总结（完成后）

## 工作流程

1. **开始** → context-manager 创建上下文
2. **开发** → 在上下文目录中工作
3. **更新** → 需要时更新静态文档
4. **完成** → context-manager 归档上下文

## 规范文件

- **规范定义**：`.claude/rules/context-engineering.md`
- **管理工具**：`.claude/agents/context-manager.md`
- **项目说明**：`CLAUDE.md`
- **更新日志**：`UPDATELOG.md`

## 快速检查

### 查看活跃上下文
```bash
cat docs/contexts/.contexts-index.json | jq '.activeContexts'
```

### 查看归档上下文
```bash
cat docs/contexts/.contexts-index.json | jq '.archivedContexts'
```

### 列出所有上下文
```bash
ls -la docs/contexts/
```

## 注意事项

- 所有 agents 自动遵循 context-engineering 规范
- 归档时不移动文件，只更新状态
- 支持多个需求并行开发
- 时间戳使用 ISO 8601 格式
- contextId 使用英文小写+下划线
