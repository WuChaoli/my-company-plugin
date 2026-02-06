# 上下文工程 - 文档管理规范

## 核心原则

**系统化的文档和代码组织是长期可维护性的基础**

---

## 目录结构

### 文档组织

| 目录 | 用途 | 说明 |
|------|------|------|
| `docs/static/` | 静态文档 | 长期维护的架构、API、指南 |
| `docs/contexts/` | 开发上下文 | 按时间+功能组织的需求、计划 |
| `docs/archive/` | 归档 | 已完成需求（只读） |

### static/ 分类

| 子目录 | 内容 |
|--------|------|
| `architecture/` | 系统架构/技术选型 |
| `design/` | 模块设计/数据流 |
| `api/` | 接口定义/协议 |
| `guide/` | 使用/部署手册 |
| `spec/` | 需求规格/验收 |

### 代码组织

| 目录 | 用途 | 说明 |
|------|------|------|
| `src/` | 源代码 | 主要实现代码 |
| `test/` | 测试代码 | 测试文件和归档 |
| `scripts/` | 脚本工具 | 构建、部署等脚本 |
| `.company/` | 公司规范 | 职位、规则、技能定义 |

### test/ 分类

| 目录/文件 | 内容 |
|-----------|------|
| `test/YYYY-MM-DD_任务名/` | 按时间归档的测试 |
| `test/README.md` | 测试归档索引 |
| `test/__init__.py` | Python 包标识 |
| `test/archived/` | 历史测试文件 |

---

## 绝对禁令

| 禁令 | 反例 | 正例 |
|------|------|------|
| **禁止跨需求混存** | 多个需求共享一个上下文目录 | 每个需求独立上下文目录 |
| **禁止修改归档** | 修改 `docs/archive/` 中的文档 | 归档只读，需要时新建 |
| **禁止根目录测试文件** | 根目录散落 `test_*.py` | 开发完成后移至 `test/` 归档 |
| **禁止跳过文档更新** | 完成功能不更新文档 | 同步更新架构/API 文档 |
| **禁止忽略测试归档** | 测试文件留在根目录 | 移至 `test/YYYY-MM-DD_任务名/` |

---

## 必须遵守

### 文档管理

- [ ] **开始新需求**: 使用 context-manager agent 初始化
- [ ] **开发过程**: 文档写入 `docs/contexts/{contextId}/`
- [ ] **完成需求**: 使用 context-manager agent 归档
- [ ] **静态文档**: 变更需要评审
- [ ] **独立隔离**: 每个需求独立文件夹
- [ ] **索引维护**: 更新 `.contexts-index.json`

### 代码组织

- [ ] **清晰分层**: src/、test/、scripts/ 分离
- [ ] **功能内聚**: 按功能域组织，不按文件类型
- [ ] **文件大小**: 200-400 行典型，≤800 行最大
- [ ] **命名清晰**: 文件名描述功能，避免缩写
- [ ] **避免循环依赖**: 模块间单向依赖

### 测试代码组织

- [ ] **开发阶段**: 根目录创建测试文件
- [ ] **测试完成**: 创建归档文件夹
- [ ] **文件归档**: 移至 `test/YYYY-MM-DD_任务名/`
- [ ] **文档更新**: 更新 `test/README.md`
- [ ] **保持根目录干净**: 及时清理测试文件

---

## 推荐做法

### 文档结构

```
docs/
├── static/                    # 静态文档（长期维护）
│   ├── architecture/          # 架构文档
│   │   ├── system-design.md
│   │   ├── database-schema.md
│   │   └── api-spec.md
│   ├── development/           # 开发指南
│   │   ├── workflow-guide.md
│   │   └── coding-standards.md
│   └── guide/                 # 使用手册
│       ├── installation.md
│       └── deployment.md
├── contexts/                  # 开发上下文（按时间+功能）
│   ├── .contexts-index.json
│   ├── 2026-01_user-auth/
│   │   ├── requirements.md
│   │   ├── design.md
│   │   └── implementation-notes.md
│   └── 2026-02_payment-flow/
│       ├── requirements.md
│       └── api-changes.md
└── archive/                   # 已完成需求（只读）
    └── 2025-12_search-feature/
```

### 代码结构

```
project/
├── src/                       # 源代码
│   ├── core/                  # 核心功能
│   ├── utils/                 # 工具函数
│   └── api/                   # API 层
├── test/                      # 测试代码
│   ├── unit/                  # 单元测试
│   ├── integration/           # 集成测试
│   ├── e2e/                   # 端到端测试
│   ├── 2026-01-20_auth_tests/ # 按时间归档
│   └── README.md              # 归档索引
├── scripts/                   # 脚本工具
│   ├── build.sh
│   └── deploy.sh
└── docs/                      # 文档
```

### 测试文件归档

**归档流程**:
1. **开发阶段**: 在根目录创建测试文件
2. **测试完成**: 创建归档文件夹
3. **文件归档**: 移动测试文件到归档文件夹
4. **文档更新**: 更新 `test/README.md`

**文件夹命名规范**:
```
test/YYYY-MM-DD_任务名称/
├── test_*.py                  # 测试文件
├── README.md                  # 测试说明（可选）
├── IMPLEMENTATION_SUMMARY.md  # 实施总结（可选）
└── results.md                 # 测试结果（可选）
```

**命名要求**:
- **日期格式**: `YYYY-MM-DD` (如: 2026-01-20)
- **任务名称**: 英文小写+下划线 (如: `custom_parser`, `api_tests`)
- **完整示例**: `2026-01-20_custom_parser`

**归档示例**:
```
test/
├── README.md                      # 归档索引
├── __init__.py                    # Python 包标识
├── 2026-01-20_custom_parser/      # 自定义 Parser 测试
│   ├── test_custom_parser.py
│   └── README.md
├── 2026-01-19_api_tests/          # API 功能测试
│   ├── test_api.py
│   ├── test_config.py
│   └── results.md
└── archived/                      # 历史归档
    └── old_test_files.py
```

---

## 验证清单

### 文档管理

- [ ] 新需求使用 context-manager 初始化
- [ ] 文档写入正确目录（static/contexts/archive）
- [ ] 更新 `.contexts-index.json`
- [ ] 归档前完成文档审查
- [ ] 归档后设为只读

### 代码组织

- [ ] src/、test/、scripts/ 分离清晰
- [ ] 文件大小 ≤800 行
- [ ] 无循环依赖
- [ ] 命名清晰描述功能
- [ ] 按功能域组织模块

### 测试归档

- [ ] 测试文件不在根目录散落
- [ ] 归档文件夹命名符合规范
- [ ] 更新 `test/README.md`
- [ ] 包含测试说明或总结
- [ ] 归档索引可查询

---

## 上下文管理

### 查看活跃上下文
读取 `docs/contexts/.contexts-index.json` 查看当前活跃任务。

### 使用 context-manager agent

| 操作 | 命令 |
|------|------|
| 开始新需求 | `开始新需求：[功能名称]` |
| 归档需求 | `归档 [contextId]` |
| 查看活跃 | `查看活跃上下文` |

---

## 工作流程

### 完整开发流程

```
1. 需求确认
   ↓
2. context-manager 初始化上下文
   ↓
3. 设计文档 → docs/contexts/{id}/
   ↓
4. 编码实现 → src/
   ↓
5. 测试验证 → 根目录测试文件
   ↓
6. 测试归档 → test/YYYY-MM-DD_任务名/
   ↓
7. 更新静态文档 → docs/static/
   ↓
8. context-manager 归档 → docs/archive/
```

### 原则

✅ 静态文档变更需评审
✅ 独立文件夹隔离
✅ 使用 agent 管理
✅ 保持根目录干净

❌ 跨需求混存
❌ 手动修改归档
❌ 直接操作 contexts/
❌ 测试文件散落根目录

---

## 常见错误认知

| 错误认知 | 真相 |
|---------|------|
| "文档可以先不写" | 代码是瞬态，文档是永恒 |
| "测试文件放根目录方便" | 根目录混乱影响开发效率 |
| "归档后可以再修改" | 归档只读，修改需新建版本 |
| "一个需求多个目录" | 混存导致上下文混乱 |

---

## 红旗警告

**当你出现以下想法时，立即停止并遵循规则：**

- "这个文档以后再写"
- "测试文件先放根目录"
- "归档了再改一下"
- "多个需求共用一个目录"
- "索引以后再更新"

---

## 与通用规则的关系

本规范是项目文档和代码组织的统一标准。

**违反本规范 = 违反组织规范**

---

## 相关文档

- **代码质量**: [code-quality.md](code-quality.md)
- **开发流程**: [development-workflow-rules.md](development-workflow-rules.md)
- **Git 工作流**: [git-workflow.md](git-workflow.md)

---

**规范版本**: 2.0
**最后更新**: 2026-02-05
**变更**: 增加代码结构和测试代码组织规范
