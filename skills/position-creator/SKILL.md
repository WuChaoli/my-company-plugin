---
name: position-creator
description: 为公司职位创建职位模板。当用户提到"创建职位模板"、"生成职位模板"、"定义职位"、"position template"或需要为架构师、产品经理、开发者等职位创建标准化职位定义时使用。创建的模板文件控制在800字以内。
---

# 职位模板创建器

为公司职位创建标准化模板。职位模板定义职责、工具、技能、文档产出、工作规则和执行后检查清单。

## 工作流程

### 1. 收集职位信息

**必需信息**：
- 职位名称、部门、核心职责（3-5条）

**可选信息**：
- 次要职责、工具、技能、文档类型、特殊规则

### 2. 读取参考资料

- `${CLAUDE_SKILL_ROOT}/assets/position-template.md` - 模板结构
- `${CLAUDE_SKILL_ROOT}/references/position-components.md` - 编写指导
- `${CLAUDE_SKILL_ROOT}/references/examples.md` - 完整示例

### 3. 定制职位模板

**模板结构**（800字以内）：

```yaml
---
role: [role-name]
position: [position-title]
department: [department-name]
version: 1.0.0
created: [YYYY-MM-DD]
updated: [YYYY-MM-DD]
skills:
  fixed:
    - doc-location-manager
  role_specific:
    - [skill-1]
    - [skill-2]
agents:
  recommended:
    - name: [agent-name-1]
      purpose: [用途说明]
    - name: [agent-name-2]
      purpose: [用途说明]
---

# [职位名称] 职位模板

## 概述
[1-2句话描述角色定位和核心价值，不超过30字]

## 职责
### 核心职责
- [核心职责1]
- [核心职责2]
- [核心职责3]

### 次要职责
- [次要职责1]
- [次要职责2]

## 工具
**必需工具**: Read, Write, [其他]
**可选工具**: Bash, Grep, Glob, [其他]

## 文档产出
**根目录**: `docs/contexts/YYYY-MM-DD_feature/`

所有[职位]相关文档直接放在特性根目录：

| 文档名称 | 位置 | 用途 | 更新频率 |
|---------|------|------|---------|
| task-todo.md | `task-todo.md` | 跨session任务跟踪 | 实时更新 |
| [文档1] | `file1.md` | [用途] | [频率] |
| [文档2] | `file2.md` | [用途] | [频率] |

**task-todo.md 格式**:
```markdown
# 任务清单

## 待办任务
- [ ] 任务1描述
- [ ] 任务2描述

## 已完成
- [x] 任务A - 完成时间: YYYY-MM-DD HH:MM
```

**目录结构示例**:
```
docs/contexts/YYYY-MM-DD_feature/
├── task-todo.md       # 任务清单（必需）
├── file1.md
└── file2.md
```

## 工作规则
1. [规则1] - [具体可执行]
2. [规则2] - [具体可执行]
3. 每次完成任务后在task-todo.md中打钩并标注完成时间
4. [规则4] - [具体可执行]

## 工作流程
### 标准流程
1. **[步骤1]**: [说明]
2. **[步骤2]**: [说明]
3. **[步骤3]**: 更新task-todo.md打钩

### 特殊场景
- **[场景1]**: [处理方式]
- **[场景2]**: [处理方式]

## 执行后检查清单

**每次完成任务后，必须逐项检查**：

- [ ] **task-todo.md已更新**: 完成的任务已打钩并标注完成时间
- [ ] **文档产出完整**: 所有必需文档已创建并更新到正确位置
- [ ] **文档路径正确**: 使用 `docs/contexts/YYYY-MM-DD_feature/` 格式
- [ ] **质量标准达标**: 代码通过测试、文档符合规范、设计经过评审
- [ ] **协作已完成**: 已通知相关人员、交接文档已准备
- [ ] **技术债务记录**: 新增的技术债务已记录到项目债务清单
- [ ] **环境已清理**: 临时文件已删除、分支状态已更新

**检查通过标准**：
- 所有检查项均为 `[x]`
- 如有未完成项，说明原因并制定补救计划
- 将检查结果记录到任务总结文档

## 质量检查
- [ ] 总字数在800字以内
- [ ] YAML frontmatter格式正确
- [ ] 包含doc-location-manager技能
- [ ] 职责清晰具体（3-5条核心职责）
- [ ] 工具列表完整
- [ ] 工作规则可执行
- [ ] 文档路径明确
- [ ] 执行后检查清单完整

## 协作接口
### 与[角色A]协作
- **场景**: [协作场景]
- **交接**: [交接文档]
```

### 4. 创建职位文件

**位置**：`.company/position/[role-name].md`

**验证**：
```bash
wc -w .company/position/[role-name].md
```

## 简洁化原则

### 各部分字数控制

- **概述**: ~30字，1-2句话
- **职责**: 核心职责3-5条，次要职责2-3条，每条一句话
- **工具**: 必需+可选分组，只列名称
- **技能**: 固定加载doc-location-manager，角色专属2-4个
- **文档产出**: 根目录+子目录结构，3-6个核心文档
- **工作规则**: 4条，每条具体可执行
- **工作流程**: 标准流程4-6步，特殊场景2-3个
- **执行后检查清单**: 6项核心检查
- **质量检查**: 4-6项
- **协作接口**: 只列主要协作角色

### 文档路径规范

**根目录**: `docs/contexts/YYYY-MM-DD_feature/`

**子目录组织**：
- `refactor/` - 重构任务
- `testing/` - 测试任务
- `arch/` - 架构任务
- `dev/` - 开发任务

**任务目录命名**: `DD-HHMM_<task_brief_name>/`

**完整示例**：
```
docs/contexts/YYYY-MM-DD_feature/
├── requirements.md              # 功能级文档
├── refactor/                    # 重构任务
│   └── DD-HHMM_<task_name>/
│       ├── tests/              # 测试代码
│       ├── baseline.md
│       └── summary.md
├── testing/                     # 测试任务
│   └── DD-HHMM_<test_desc>/
│       ├── test-cases.md
│       └── execution-log.md
└── arch/                        # 架构任务
    └── DD-HHMM_<arch_task>/
        ├── design.md
        └── diff.md
```

## 常用技能参考

**必需**:
- `doc-location-manager` - 文档位置管理

**工作流管理**:
- `context-engineering` - 上下文工程（文档归档、上下文管理）
- `brainstorming` - 创意思考和需求探索
- `checkpoint` - 开发检查点管理
- `session-compact` - 会话压缩和清理

**开发流程**:
- `tdd-workflow` - 测试驱动开发（TDD）
- `requesting-code-review` - 请求代码审查
- `commit-commands:commit` - Git提交
- `commit-commands:commit-push-pr` - 提交、推送并创建PR

**架构与设计**:
- `c4-architecture` - C4架构图生成
- `mermaid-diagrams` - Mermaid图表绘制
- `architecture-generator` - 自动生成项目架构文档
- `using-git-worktrees` - Git工作树管理

**Agent相关**:
- `agent-creator` - 创建自定义Agent
- `agent-usage-guide` - Agent使用规范指南
- `personality-creator` - 创建人格模板

**插件开发**:
- `plugin-dev:plugin-structure` - 插件结构指南
- `plugin-dev:command-development` - 命令开发
- `plugin-dev:skill-development` - 技能开发
- `plugin-dev:agent-development` - Agent开发
- `plugin-dev:hook-development` - Hook开发
- `plugin-dev:mcp-integration` - MCP集成

**规则与规范**:
- `rule-creator` - 创建行为规范和工作流规则

**LSP配置**:
- `lsp-setup` - LSP安装、配置和使用指南

**其他工具**:
- `permission-usage` - 权限设置配置指南
- `fire-employee` - 删除员工档案

## 字数分配

总字数控制在800字以内：

- YAML frontmatter: ~80字（包含 skills 和 agents）
- 概述: ~30字
- 职责: ~100字
- 工具: ~50字
- 文档产出: ~120字
- 工作规则: ~80字
- 工作流程: ~120字
- 执行后检查清单: ~100字
- 质量检查: ~60字
- 协作接口: ~60字
- **总计**: ~800字

## 快速开始

1. 调用 `/position-creator`
2. 回答职位相关问题
3. 查看生成的模板
4. 验证字数在800字以内
5. 保存到 `.company/position/[role-name].md`

## 注意事项

1. **字数限制**: 800字以内
2. **doc-location-manager必需**: 所有职位模板都必须包含
3. **文档路径规范**: 使用相对路径，明确根目录
4. **规则可执行性**: 规则要具体可执行
5. **task-todo.md必需**: 每个职位模板必须包含任务跟踪文档
6. **每次任务完成后打钩**: 更新task-todo.md并标注完成时间
7. **执行后检查**: 每次任务完成后必须执行检查清单
8. **模板复用**: 创建员工时从模板复制

## 相关资源

- **职位模板**: `${CLAUDE_SKILL_ROOT}/assets/position-template.md`
- **组件说明**: `${CLAUDE_SKILL_ROOT}/references/position-components.md`
- **示例职位**: `${CLAUDE_SKILL_ROOT}/references/examples.md`
- **招聘员工**: `/hire-employee`
- **文档位置管理**: `skills/doc-location-manager`

---

**版本**: 2.4.0 | **更新**: 2026-02-06
**变更**: 新增 skills 和 agents 元数据到 YAML frontmatter，更新模板结构和章节编号
