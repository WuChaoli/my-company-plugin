# 开发上下文

本目录包含所有开发上下文，按时间+功能组织，支持并行开发。

## 目录结构

每个上下文目录格式：`YYYY-MM-DD_feature-name/`

示例：
```
contexts/
├── .contexts-index.json          # 上下文索引
├── 2026-02-01_user-authentication/  # 进行中
│   ├── .context.json
│   ├── requirements.md
│   ├── architecture-changes.md
│   ├── feature-spec.md
│   ├── plan.md
│   ├── todos.md
│   └── test-plan.md
└── 2026-01-30_payment-integration/  # 已归档
    ├── .context.json
    ├── SUMMARY.md
    └── ...
```

## 上下文状态

- **in_progress**: 正在进行中的开发任务
- **archived**: 已完成并归档的任务

## 使用方法

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

## 注意事项

1. 所有上下文统一在此目录下
2. 通过 `.context.json` 的 `status` 字段区分状态
3. 归档时不移动文件，只更新状态
4. 使用 `.contexts-index.json` 快速查找活跃上下文
5. 支持多人并行开发不同需求
