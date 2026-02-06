---
name: hire-employee
description: 从职位模板创建员工档案。当用户提到"招聘员工"、"雇佣员工"、"创建员工档案"、"hire employee"或需要将 .company/position/ 中的职位模板实例化为具体员工时使用。同时支持使用 <load:position-employee_name> 命令激活员工。
---

# 员工招聘器

## 概述

从职位模板创建具体员工档案，并支持通过命令快速激活员工。

**设计原则**：员工档案采用引用方式，不复制职位和人格内容。激活员工时动态读取最新的职位和人格文档，确保内容始终保持同步。

员工档案 = 基本信息 + 职位引用 + 人格引用

## 工作流程

### 1. 收集信息

**必需**：
- 员工姓名（如：张三、李四）
- 职位（从 `.company/position/` 选择）
- 人格类型（从 `.company/personality/` 选择）

**可选**：
- 性别、入职日期（默认今天）

### 2. 读取模板

```bash
# 查看可用职位
ls .company/position/

# 查看可用人格
ls .company/personality/

# 查看可用规则
ls .company/rules/
```

读取：
- `.company/position/[职位].md` - 职责、工具、技能（用于了解职位内容，不复制到员工档案）
- `.company/personality/[人格].md` - 核心特征、工作风格（用于了解人格特征，不复制到员工档案）
- `.company/rules/workflow.md` - **最高宪法，必须引用**
- `.company/rules/code-quality.md` - 代码质量、测试、安全规则（如职位涉及代码编写）
- `.company/rules/context-engineering.md` - 文档管理规范（所有职位必需）
- `${CLAUDE_SKILL_ROOT}/assets/employee-template.md` - 员工档案模板（引用式）
- `${CLAUDE_SKILL_ROOT}/assets/command-template.md` - 激活命令模板（引用式）

### 3. 生成员工ID

**命名格式**：`[职位]-[姓名]`

**示例**：
- 测试工程师张三：`test-engineer-张三`
- 架构师李四：`architect-李四`
- 需求规划师造梦：`requirement-planner-造梦`

### 4. 创建档案

**文件位置**：`.company/employee/[职位]-[姓名].md`

**结构**（引用式，约250字）：
```yaml
---
employee_id: test-engineer-张三
name: 张三
gender: 男
position: test-engineer
personality: analytical-type
hire_date: 2026-02-02
status: active
---

# 张三 - 测试工程师

## 基本信息
- **ID**: test-engineer-张三
- **姓名**: 张三
- **性别**: 男
- **职位**: 测试工程师 ([test-engineer](.company/position/test-engineer.md))
- **人格**: 分析型 ([analytical-type](.company/personality/analytical-type.md))
- **入职日期**: 2026-02-02
- **状态**: 在职

## 工作规则

本员工遵循以下规则（按优先级排序）：

### 最高宪法
- **[workflow.md](.company/rules/workflow.md)** - 工作流程规范（Agent编排、SKILL调用、TDD、系统化调试、工作隔离、代码审查）

### 开发规则（根据职位相关度引用）
- **[code-quality.md](.company/rules/code-quality.md)** - 代码质量、测试、安全规范（不可变性、函数大小、错误处理、安全检查、测试覆盖率等）
- **[context-engineering.md](.company/rules/context-engineering.md)** - 文档管理规范（文档组织、代码结构、测试归档）

## 职位与人格

本员工的职责、工具、技能、工作流程等详细信息请参考：
- **职位模板**: [.company/position/test-engineer.md](.company/position/test-engineer.md)
- **人格模板**: [.company/personality/analytical-type.md](.company/personality/analytical-type.md)

激活该员工时，请先阅读上述规则、职位和人格文档以获取完整的工作配置。

---
**创建**: 2026-02-02
```

### 5. 更新员工配置文件

**配置文件位置**：`.company/employee/.employees-registry.json`

**首次创建**（如果文件不存在）：
```json
{
  "version": "1.0.0",
  "last_updated": "2026-02-04",
  "employees": []
}
```

**添加员工记录**：
```json
{
  "employee_id": "test-engineer-张三",
  "name": "张三",
  "position": "test-engineer",
  "personality": "analytical-type",
  "hire_date": "2026-02-02",
  "status": "active",
  "command": "load:test-engineer-张三",
  "file": ".company/employee/test-engineer-张三.md"
}
```

**操作步骤**：
1. 读取现有配置文件（如不存在则创建）
2. 添加新员工记录到 `employees` 数组
3. 更新 `last_updated` 字段
4. 写回配置文件

### 6. 创建激活命令

在 `commands/` 目录创建命令文件：`load-[职位]-[姓名].md`

**命名规则**：
- 如果员工使用中文名，命令中的姓名部分使用中文（如：`load-test-engineer-王麻子.md`）
- 如果员工使用英文名，命令中的姓名部分使用英文（如：`load-test-engineer-john-smith.md`）

**命令模板**（引用式）：
```yaml
---
name: load:test-engineer-张三
description: 激活员工张三（测试工程师）。使用该员工的档案、职责、工具、技能和工作规则进行工作。
---

# 激活员工：张三

正在加载员工档案...

## 第1步：读取员工基本信息

请先阅读员工档案：[.company/employee/test-engineer-张三.md](.company/employee/test-engineer-张三.md)

## 第2步：读取最高宪法（必须）

请阅读最高宪法规则：
- **[workflow.md](.company/rules/workflow.md)** - 工作流程规范（Agent编排、SKILL调用、TDD、系统化调试、工作隔离）

**这是最高规则，优先级高于所有其他规则，必须严格遵守。**

## 第3步：读取职位配置

请阅读职位模板以获取完整的职责、工具、技能、工作流程等信息：
- **职位模板**: [.company/position/test-engineer.md](.company/position/test-engineer.md)

## 第4步：读取人格特征

请阅读人格模板以了解工作风格和行为特征：
- **人格模板**: [.company/personality/analytical-type.md](.company/personality/analytical-type.md)

## 第5步：读取开发规则（根据职位需要）

根据职位类型，阅读相关的开发规则：

**所有职位都必须阅读**：
- **[context-engineering.md](.company/rules/context-engineering.md)** - 文档管理规范

**如果职位涉及代码编写或开发工作**（如开发工程师、测试工程师、重构工程师）：
- **[code-quality.md](.company/rules/code-quality.md)** - 代码质量、测试、安全规范

## 第6步：开始工作

现在你已经加载了：
- ✓ 员工基本信息（姓名、ID、入职日期等）
- ✓ 最高宪法规则（Agent编排、SKILL调用、工作流程）
- ✓ 职位配置（职责、工具、技能、工作流程、文档产出等）
- ✓ 人格特征（核心特征、工作风格）
- ✓ 开发规则（代码质量、开发流程，如适用）

请根据以上配置开始工作。记住：
1. **最高宪法具有最高优先级**，所有其他规则都必须符合宪法原则
2. 严格遵循职位模板中定义的工作流程和规则
3. 按照人格特征中描述的风格进行沟通和决策
4. 使用职位模板中指定的工具和技能
5. 按照文档产出规范组织输出文档
```

## 快速开始

**第1步**：调用 `/hire-employee`

**第2步**：提供信息
```
姓名：张三
职位：test-engineer
人格：analytical-type
```

**第3步**：确认生成

**第4步**：使用命令激活
```
/load:test-engineer-张三
```

## 员工配置文件管理

### 配置文件位置
`.company/employee/.employees-registry.json`

### 配置文件结构
```json
{
  "version": "1.0.0",
  "last_updated": "2026-02-04",
  "employees": [
    {
      "employee_id": "test-engineer-张三",
      "name": "张三",
      "position": "test-engineer",
      "personality": "analytical-type",
      "hire_date": "2026-02-02",
      "status": "active",
      "command": "load:test-engineer-张三",
      "file": ".company/employee/test-engineer-张三.md"
    }
  ]
}
```

### 查询在职员工
```bash
# 读取配置文件
cat .company/employee/.employees-registry.json | jq '.employees[] | select(.status=="active")'

# 查看所有员工
cat .company/employee/.employees-registry.json | jq '.employees'
```

### 更新员工状态
当员工离职时，更新配置文件中的 `status` 字段为 `"inactive"`。

### 配置文件字段说明
- `employee_id`: 员工唯一标识符（格式：职位-姓名）
- `name`: 员工姓名
- `position`: 职位（对应 .company/position/ 中的职位模板）
- `personality`: 人格类型（对应 .company/personality/ 中的人格模板）
- `hire_date`: 入职日期
- `status`: 员工状态（active=在职, inactive=离职）
- `command`: 激活命令（用于快速激活员工）
- `file`: 员工档案文件路径

## 档案内容原则

### 引用式设计
- **不复制内容**：员工档案不复制职位和人格的详细内容
- **仅保留引用**：通过文件路径引用职位和人格模板
- **动态加载**：激活员工时实时读取最新的职位和人格配置
- **单一数据源**：职位和人格模板是唯一的数据源，确保一致性

### 档案结构（约250字）
- **YAML frontmatter**：员工ID、姓名、性别、职位、人格、入职日期、状态
- **基本信息**：ID、姓名、性别、职位（带链接）、人格（带链接）、入职日期、状态
- **工作规则**：
  - 最高宪法（workflow.md）- 必须引用，最高优先级
  - 开发规则（code-quality.md, context-engineering.md）- 根据职位相关度引用
- **职位与人格**：说明需要参考的职位和人格模板文件路径
- **激活说明**：提示激活时需要阅读引用的文档

### 命令文件结构（引用式）
- **步骤1**：读取员工档案（基本信息）
- **步骤2**：读取最高宪法（必须，workflow.md）
- **步骤3**：读取职位模板（完整配置）
- **步骤4**：读取人格模板（工作风格）
- **步骤5**：读取开发规则（根据职位需要）
  - 所有职位：context-engineering.md
  - 涉及代码/开发工作：code-quality.md
- **步骤6**：开始工作（提示遵循规则，强调最高宪法优先级）

### 优势
- ✓ 职位/人格/规则更新自动生效
- ✓ 无内容重复，易于维护
- ✓ 档案文件简洁（250字 vs 2500字）
- ✓ 单一数据源，避免不一致
- ✓ 规则分层：最高宪法 > 开发规则 > 职位规则
- ✓ 规则按需引用，避免不相关规则干扰

## 命名规范

### 员工ID格式
**格式**：`[职位]-[姓名]`

**规则**：
- 职位使用职位模板的英文名称（如：test-engineer、architect）
- 姓名保持原样（中文或英文）

**示例**：
- `test-engineer-张三` - 测试工程师张三
- `architect-李四` - 架构师李四
- `requirement-planner-造梦` - 需求规划师造梦
- `tdd-developer-鲁班` - TDD开发工程师鲁班

### 激活命令格式
**格式**：`load:[职位]-[姓名]`

**示例**：
- `load:test-engineer-张三` - 激活测试工程师张三
- `load:architect-师爷` - 激活架构师师爷
- `load:refactor-engineer-罗辑` - 激活重构工程师罗辑

### 文件命名
**命令文件**：`load-[职位]-[姓名].md`
- `load-test-engineer-张三.md`
- `load-architect-师爷.md`

**员工档案**：`[职位]-[姓名].md`
- `test-engineer-张三.md`
- `architect-师爷.md`

## 相关资源

- **职位模板**: `.company/position/`
- **人格模板**: `.company/personality/`
- **工作规则**: `.company/rules/`
  - `workflow.md` - 工作流程规范（必须引用，最高宪法）
  - `code-quality.md` - 代码质量、测试、安全规范
  - `context-engineering.md` - 文档管理规范（所有职位必需）
- **员工模板**: `${CLAUDE_SKILL_ROOT}/assets/employee-template.md`
- **创建职位**: `/position-creator`

---

**版本**: 1.3.0 | **更新**: 2026-02-05 | **变更**: 更新规则文件引用（workflow.md, code-quality.md, context-engineering.md）
