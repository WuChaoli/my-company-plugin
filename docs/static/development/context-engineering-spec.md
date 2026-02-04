# Context Engineering - 上下文工程规范

## 概述

这是项目的文档管理规范，定义了开发过程中文档的组织方式。所有 agents 都应遵循此规范。

## 目录结构

```
project/
├── docs/
│   ├── static/                    # 静态文档（长期维护）
│   │   ├── architecture/          # 架构文档
│   │   ├── user-journey/          # 用户旅程
│   │   ├── data-flow/             # 数据流动图
│   │   └── api/                   # API 接口文档
│   │
│   └── contexts/                  # 开发上下文（按时间+功能）
│       ├── .contexts-index.json  # 上下文索引
│       └── YYYY-MM-DD_feature-name/  # 具体上下文（根目录）
│           ├── .context.json     # 元数据
│           ├── requirements.md   # 需求文档
│           ├── feature-spec.md   # 功能规格
│           ├── plan.md           # 实施计划
│           ├── todos.md          # 任务清单
│           │
│           ├── refactor/         # 重构相关（按任务组织）
│           │   └── DD-HHMM_<task_brief_name>/
│           │       ├── tests/    # 测试代码
│           │       ├── baseline.md
│           │       ├── plan.md
│           │       └── summary.md
│           │
│           ├── testing/          # 测试相关（按任务组织）
│           │   └── DD-HHMM_<test_desc>/
│           │       ├── test-cases.md
│           │       ├── execution-log.md
│           │       └── summary.md
│           │
│           └── arch/             # 架构相关（按任务组织）
│               └── DD-HHMM_<arch_task>/
│                   ├── design.md
│                   ├── diff.md
│                   └── sync.md
```

### 子目录组织原则

**根目录** (`docs/contexts/YYYY-MM-DD_feature/`)：
- 存放功能级别的通用文档（requirements.md, feature-spec.md 等）
- 按职位/任务类型创建子目录

**子目录** (`refactor/`, `testing/`, `arch/` 等)：
- 按职位或任务类型组织
- 避免不同职位的文档混在一起

**任务目录** (`DD-HHMM_<task_brief_name>/`)：
- 每个具体任务创建独立目录
- 使用时间戳+任务简述命名
- 包含该任务的所有文档和代码

## 工作流程

### 1. 开始新需求
使用 context-manager agent：
```
开始新需求：[功能名称]
```

### 2. 开发过程
- 将文档写入 `docs/contexts/[contextId]/`
- 更新静态文档时写入 `docs/static/[category]/`
- 在 `.context.json` 中记录更新的静态文档

### 3. 查找当前上下文
读取 `docs/contexts/.contexts-index.json` 查看 `activeContexts`

### 4. 完成需求
使用 context-manager agent：
```
归档 [contextId]
```

## 文档类型

### 静态文档 (docs/static/)
按功能模块组织，长期维护：
- **architecture/** - 系统架构、组件设计、ADR
- **user-journey/** - 用户旅程和交互流程
- **data-flow/** - 数据流动和处理逻辑
- **api/** - API 接口文档

### 动态文档 (docs/contexts/[contextId]/)
按时间+功能组织，支持并行开发：

**根目录文档**（功能级别）：
- **requirements.md** - 需求文档
- **feature-spec.md** - 功能规格
- **plan.md** - 实施计划
- **todos.md** - 任务清单
- **SUMMARY.md** - 归档总结（完成后生成）

**子目录文档**（任务级别）：
- **refactor/** - 重构任务文档和测试代码
- **testing/** - 测试任务文档和执行日志
- **arch/** - 架构设计和分析文档
- **dev/** - 开发任务文档和日志

每个子目录下按 `DD-HHMM_<task_brief_name>/` 组织具体任务。

## 元数据格式

### .context.json
```json
{
  "contextId": "2026-01-20_user-authentication",
  "status": "in_progress",
  "createdAt": "2026-01-20T10:00:00Z",
  "updatedAt": "2026-01-20T15:30:00Z",
  "completedAt": null,
  "title": "用户认证功能",
  "description": "实现基于 JWT 的用户认证系统",
  "assignee": "developer-name",
  "gitBranch": "feature/user-auth",
  "documents": {
    "requirements": "requirements.md",
    "architectureChanges": "architecture-changes.md",
    "featureSpec": "feature-spec.md",
    "plan": "plan.md",
    "todos": "todos.md",
    "testPlan": "test-plan.md"
  },
  "staticDocsUpdated": []
}
```

### .contexts-index.json
```json
{
  "activeContexts": [
    {
      "contextId": "2026-01-20_user-authentication",
      "title": "用户认证功能",
      "status": "in_progress",
      "assignee": "developer-name",
      "updatedAt": "2026-01-20T15:30:00Z"
    }
  ],
  "archivedContexts": []
}
```

## 最佳实践

1. **始终检查当前上下文** - 读取 `.contexts-index.json` 确认活跃上下文
2. **及时更新元数据** - 修改文档后更新 `.context.json` 的 `updatedAt`
3. **记录静态文档变更** - 在 `staticDocsUpdated` 中记录所有变更
4. **保持文档同步** - 架构变更要同时更新动态和静态文档
5. **完整的归档** - 归档时确保生成完整的 SUMMARY.md
6. **经验积累** - 将关键经验提取到项目级 CLAUDE.md
7. **子目录组织** - 按职位/任务类型创建子目录，避免文档混乱
8. **任务目录命名** - 使用 `DD-HHMM_<task_brief_name>` 格式，避免覆盖
9. **明确根目录** - 在职位模板中明确说明根目录，然后使用相对路径

## 注意事项

- 所有上下文统一在 `docs/contexts/` 目录下
- 通过 `status` 字段区分活跃和归档状态
- 归档时不移动文件，只更新状态
- 使用索引文件快速查找上下文
- 支持多人并行开发不同需求
- 时间戳使用 ISO 8601 格式
- contextId 使用英文小写+下划线
