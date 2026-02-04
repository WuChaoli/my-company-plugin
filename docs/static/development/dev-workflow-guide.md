# Dev Workflow 实施指南

本文档提供 `/dev-workflow` command 的详细实施指南和最佳实践。

## 快速开始

### 1. 选择工作流类型

根据任务复杂度选择合适的工作流:

| 工作流类型 | 适用场景 | 预计时间 | Agent 数量 |
|-----------|---------|---------|-----------|
| `full-feature` | 新功能开发，需要完整文档 | 完整流程 | 7 个 |
| `quick-feature` | 简单功能，快速实现 | 快速流程 | 3 个 |
| `architecture-first` | 复杂系统，架构优先 | 完整流程 | 5 个 |
| `refactor` | 代码重构，优化结构 | 中等流程 | 4 个 |

### 2. 执行工作流

```bash
# 示例：完整功能开发
/dev-workflow full-feature "实现用户认证功能"

# 示例：快速功能
/dev-workflow quick-feature "添加导出功能"

# 示例：架构优先
/dev-workflow architecture-first "设计缓存系统"

# 示例：重构
/dev-workflow refactor "重构数据访问层"
```

## 工作流详解

### Full-Feature Workflow

**适用场景**: 需要完整文档和架构设计的新功能

**执行步骤**:

#### Step 1: 初始化上下文 (Context Manager)

**目标**: 创建开发上下文目录和元数据

**执行**:
```markdown
调用 context-manager agent:
- 创建 docs/contexts/YYYY-MM-DD_feature-name/
- 初始化 metadata.json
- 创建基础文档结构
```

**输出**:
- Context ID: `2026-02-01_user-auth`
- 工作目录: `docs/contexts/2026-02-01_user-auth/`

**交接给下一个 agent**:
```markdown
## HANDOFF: context-manager -> code-new-requirement

### 完成内容
- 创建开发上下文: 2026-02-01_user-auth
- 初始化文档目录结构

### 工作目录
docs/contexts/2026-02-01_user-auth/

### 待办事项
- 分析用户需求
- 生成需求文档

### 建议
- 重点关注认证流程和安全性
- 考虑多种认证方式（密码、OAuth、JWT）
```

#### Step 2: 需求分析 (Code New Requirement)

**目标**: 与用户交流，明确需求，生成结构化需求文档

**执行**:
```markdown
调用 code-new-requirement agent:
- 向用户提问澄清需求
- 分析功能需求和非功能需求
- 生成 requirements.md
```

**输出**:
- `docs/contexts/2026-02-01_user-auth/requirements.md`

**交接给下一个 agent**:
```markdown
## HANDOFF: code-new-requirement -> code-architect

### 完成内容
- 需求分析完成
- 生成需求文档: requirements.md

### 关键需求
- 支持用户名/密码登录
- 支持 JWT token 认证
- 支持密码重置功能
- 需要 RBAC 权限控制

### 修改文件
- docs/contexts/2026-02-01_user-auth/requirements.md

### 待办事项
- 设计认证架构
- 设计数据模型
- 设计 API 接口

### 建议
- 使用成熟的认证库（如 Passport.js）
- 考虑使用 Redis 存储 session
- 设计清晰的权限模型
```

#### Step 3: 架构设计 (Code Architect)

**目标**: 基于需求进行系统架构、代码架构、数据架构设计

**执行**:
```markdown
调用 code-architect agent:
- 使用 C4 模型设计系统架构
- 设计代码结构和模块划分
- 设计数据库模型
- 生成 architecture.md
```

**输出**:
- `docs/contexts/2026-02-01_user-auth/architecture.md`
- 包含 C4 架构图（Context, Container, Component）

**交接给下一个 agent**:
```markdown
## HANDOFF: code-architect -> code-planner

### 完成内容
- 系统架构设计完成
- 代码架构设计完成
- 数据架构设计完成
- 生成架构文档: architecture.md

### 关键设计决策
- 使用 JWT 进行无状态认证
- 使用 bcrypt 加密密码
- 使用 Redis 存储 refresh token
- 采用三层架构：Controller -> Service -> Repository

### 核心模块
- AuthController: 处理认证请求
- AuthService: 认证业务逻辑
- UserRepository: 用户数据访问
- TokenService: Token 管理

### 数据模型
- User: 用户表
- Role: 角色表
- Permission: 权限表
- RefreshToken: 刷新令牌表

### 修改文件
- docs/contexts/2026-02-01_user-auth/architecture.md

### 待办事项
- 制定详细的开发计划
- 分解开发任务
- 识别技术依赖

### 建议
- 先实现核心认证功能
- 再实现权限控制
- 最后实现密码重置
```

#### Step 4: 开发计划 (Code Planner)

**目标**: 将需求和架构转化为可执行的开发计划

**执行**:
```markdown
调用 code-planner agent:
- 分解开发任务
- 识别文件和依赖
- 制定实施顺序
- 生成 plan.md
```

**输出**:
- `docs/contexts/2026-02-01_user-auth/plan.md`

**交接给下一个 agent**:
```markdown
## HANDOFF: code-planner -> code-tdd-dev

### 完成内容
- 开发计划制定完成
- 任务分解完成
- 生成开发计划: plan.md

### 开发阶段
Phase 1: 数据模型和 Repository
- 创建 User, Role, Permission 模型
- 实现 UserRepository
- 编写单元测试

Phase 2: 认证服务
- 实现 AuthService
- 实现 TokenService
- 编写单元测试

Phase 3: API 接口
- 实现 AuthController
- 实现中间件
- 编写集成测试

Phase 4: 权限控制
- 实现 RBAC 逻辑
- 实现权限中间件
- 编写 E2E 测试

### 关键文件
新增:
- src/models/User.ts
- src/models/Role.ts
- src/repositories/UserRepository.ts
- src/services/AuthService.ts
- src/services/TokenService.ts
- src/controllers/AuthController.ts
- src/middleware/auth.ts

修改:
- src/routes/index.ts
- src/app.ts

### 技术依赖
- jsonwebtoken
- bcrypt
- express-validator
- redis

### 修改文件
- docs/contexts/2026-02-01_user-auth/plan.md

### 待办事项
- 按照 TDD 方式实施开发
- 确保测试覆盖率 > 80%
- 遵循架构设计

### 建议
- 严格按照 Phase 顺序开发
- 每个 Phase 完成后运行测试
- 及时提交代码
```

#### Step 5: TDD 开发 (Code TDD Dev)

**目标**: 按照 TDD 方式实施开发

**执行**:
```markdown
调用 code-tdd-dev agent:
- 按照计划的 Phase 顺序开发
- 先写测试，再写实现
- 确保测试通过
- 重构优化
```

**输出**:
- 实现代码文件
- 测试文件
- 测试报告

**交接给下一个 agent**:
```markdown
## HANDOFF: code-tdd-dev -> doc-updater

### 完成内容
- 所有 Phase 开发完成
- 测试覆盖率: 85%
- 所有测试通过

### 实现文件
新增:
- src/models/User.ts
- src/models/Role.ts
- src/repositories/UserRepository.ts
- src/services/AuthService.ts
- src/services/TokenService.ts
- src/controllers/AuthController.ts
- src/middleware/auth.ts
- test/unit/AuthService.test.ts
- test/integration/AuthController.test.ts
- test/e2e/auth.test.ts

修改:
- src/routes/index.ts
- src/app.ts
- package.json

### 测试结果
- 单元测试: 45/45 通过
- 集成测试: 12/12 通过
- E2E 测试: 8/8 通过
- 覆盖率: 85%

### 关键功能
- ✓ 用户注册
- ✓ 用户登录
- ✓ Token 刷新
- ✓ 密码重置
- ✓ RBAC 权限控制

### 待办事项
- 更新 API 文档
- 更新 README
- 更新架构文档（如有变更）

### 建议
- 重点更新 API 接口文档
- 添加使用示例
- 更新部署说明
```

#### Step 6: 文档更新 (Doc Updater)

**目标**: 更新项目文档，生成 API 文档

**执行**:
```markdown
调用 doc-updater agent:
- 更新 API 文档
- 更新 README
- 更新架构文档（如有变更）
- 生成使用示例
```

**输出**:
- 更新的文档文件

**交接给下一个 agent**:
```markdown
## HANDOFF: doc-updater -> context-manager

### 完成内容
- API 文档更新完成
- README 更新完成
- 使用示例添加完成

### 更新文件
- docs/api/auth.md
- README.md
- docs/examples/auth-usage.md

### 文档内容
- API 接口说明
- 请求/响应示例
- 错误码说明
- 使用示例代码

### 待办事项
- 归档开发上下文
- 生成实施总结

### 建议
- 总结开发过程中的经验教训
- 记录遇到的问题和解决方案
```

#### Step 7: 归档上下文 (Context Manager)

**目标**: 归档开发上下文，生成实施总结

**执行**:
```markdown
调用 context-manager agent:
- 更新 metadata.json 状态为 completed
- 生成 IMPLEMENTATION_SUMMARY.md
- 更新 .contexts-index.json
```

**输出**:
- `docs/contexts/2026-02-01_user-auth/IMPLEMENTATION_SUMMARY.md`
- 更新的 metadata.json
- 更新的 .contexts-index.json

**最终报告**:
```markdown
## 工作流完成

### 上下文信息
- Context ID: 2026-02-01_user-auth
- 状态: completed
- 位置: docs/contexts/2026-02-01_user-auth/

### 生成文档
- requirements.md
- architecture.md
- plan.md
- IMPLEMENTATION_SUMMARY.md

### 实施结果
- 代码文件: 7 个新增, 2 个修改
- 测试文件: 3 个
- 测试覆盖率: 85%
- 文档更新: 3 个

### 状态
✓ 可以发布
```

### Quick-Feature Workflow

**适用场景**: 简单功能，快速实现

**执行步骤**:

1. **需求分析** (code-new-requirement)
   - 快速确认需求
   - 生成简化需求文档

2. **开发计划** (code-planner)
   - 创建开发计划
   - 识别关键文件

3. **TDD 开发** (code-tdd-dev)
   - TDD 开发
   - 测试验证

**特点**:
- 跳过架构设计（适用于简单功能）
- 跳过文档更新（可后续补充）
- 不创建独立上下文（可选）

### Architecture-First Workflow

**适用场景**: 复杂系统，架构优先

**执行步骤**:

1. **需求分析** (code-new-requirement)
   - 详细需求分析
   - 识别架构需求

2. **架构设计** (code-architect)
   - 深度架构设计
   - 系统/代码/数据架构

3. **开发计划** (code-planner)
   - 基于架构的实施计划

4. **TDD 开发** (code-tdd-dev)
   - 按架构实施

5. **文档更新** (doc-updater)
   - 完整文档更新

**特点**:
- 强调架构设计
- 适合复杂系统
- 完整文档输出

### Refactor Workflow

**适用场景**: 代码重构，优化结构

**执行步骤**:

1. **架构设计** (code-architect)
   - 分析现有架构
   - 设计重构方案

2. **开发计划** (code-planner)
   - 制定重构计划
   - 识别风险点

3. **清理代码** (refactor-cleaner)
   - 清理冗余代码
   - 移除死代码

4. **TDD 开发** (code-tdd-dev)
   - 重构实施
   - 测试保护

**特点**:
- 包含代码清理步骤
- 强调测试保护
- 渐进式重构

## 进度管理

### 任务创建

在工作流开始时，创建所有任务:

```typescript
// 示例：full-feature 工作流的任务创建
TaskCreate({
  subject: "初始化上下文",
  description: "使用 context-manager 创建开发上下文",
  activeForm: "正在初始化上下文"
})

TaskCreate({
  subject: "需求分析",
  description: "使用 code-new-requirement 分析需求",
  activeForm: "正在分析需求"
})

TaskCreate({
  subject: "架构设计",
  description: "使用 code-architect 设计架构",
  activeForm: "正在设计架构"
})

// ... 其他任务
```

### 任务执行

执行每个任务时:

```typescript
// 1. 标记为进行中
TaskUpdate({
  taskId: "2",
  status: "in_progress"
})

// 2. 调用 agent
Task({
  subagent_type: "code-new-requirement",
  prompt: "分析用户认证功能需求...",
  description: "需求分析"
})

// 3. 标记为完成
TaskUpdate({
  taskId: "2",
  status: "completed"
})
```

### 进度查看

随时查看整体进度:

```typescript
TaskList()
```

输出示例:
```
ID | Subject      | Status      | Owner
---|--------------|-------------|-------
1  | 初始化上下文  | completed   | -
2  | 需求分析     | completed   | -
3  | 架构设计     | in_progress | -
4  | 开发计划     | pending     | -
5  | TDD 开发     | pending     | -
6  | 文档更新     | pending     | -
7  | 归档上下文   | pending     | -
```

## 最佳实践

### 1. 选择合适的工作流

- **新功能 + 需要文档** → `full-feature`
- **简单功能 + 快速实现** → `quick-feature`
- **复杂系统 + 架构重要** → `architecture-first`
- **代码优化 + 清理冗余** → `refactor`

### 2. 充分利用交接文档

每个 agent 的输出都会作为下一个 agent 的输入:
- 保持交接文档简洁但完整
- 突出关键信息和待办事项
- 提供明确的建议

### 3. 监控进度

- 使用 `TaskList` 查看整体进度
- 每个阶段完成后检查输出
- 及时发现和解决问题

### 4. 保存工作流状态

- 所有文档都保存在上下文目录中
- 可以随时查看历史记录
- 便于后续回顾和学习

### 5. 灵活调整

- 如果某个 agent 不适用，可以跳过
- 可以根据需要添加额外的 agent
- 可以自定义工作流顺序

## 故障处理

### Agent 执行失败

如果某个 agent 执行失败:

1. **查看错误信息**
   ```markdown
   ## ERROR: code-architect
   - 错误信息: Agent execution timeout
   - 失败原因: 架构设计过于复杂
   ```

2. **决策**
   - 重试当前 agent
   - 跳过继续（如果不是关键步骤）
   - 终止工作流

3. **更新任务状态**
   ```typescript
   TaskUpdate({
     taskId: "3",
     status: "pending",  // 重置为待处理
     description: "架构设计 - 重试中"
   })
   ```

### 工作流中断

如果工作流被中断:

1. **查看当前状态**
   ```typescript
   TaskList()
   ```

2. **恢复工作流**
   ```bash
   # 从中断点继续
   /dev-workflow resume 2026-02-01_user-auth
   ```

3. **手动继续**
   - 查看最后完成的 agent
   - 手动调用下一个 agent
   - 继续工作流

## 示例场景

### 场景 1: 实现用户认证

```bash
/dev-workflow full-feature "实现用户认证功能，支持用户名/密码登录、JWT token、密码重置、RBAC 权限控制"
```

**预期输出**:
- 完整的需求文档
- 系统架构设计（C4 图）
- 详细的开发计划
- 实现代码 + 测试
- API 文档
- 实施总结

### 场景 2: 添加导出功能

```bash
/dev-workflow quick-feature "添加用户数据导出为 CSV 功能"
```

**预期输出**:
- 简化的需求文档
- 开发计划
- 实现代码 + 测试

### 场景 3: 设计缓存系统

```bash
/dev-workflow architecture-first "设计分布式缓存系统，支持 Redis 集群"
```

**预期输出**:
- 详细需求分析
- 深度架构设计
- 实施计划
- 实现代码
- 完整文档

### 场景 4: 重构数据访问层

```bash
/dev-workflow refactor "重构数据访问层，统一使用 Repository 模式"
```

**预期输出**:
- 架构分析和重构方案
- 重构计划
- 清理冗余代码
- 重构实施 + 测试

## 总结

`/dev-workflow` command 提供了一个结构化的开发流程，通过编排多个专业 agents，确保:

1. **完整性**: 从需求到实施到文档的完整流程
2. **质量**: TDD 开发，测试覆盖率保证
3. **可追溯**: 所有文档和决策都有记录
4. **可管理**: 清晰的进度追踪和任务管理

选择合适的工作流类型，按照指南执行，可以显著提高开发效率和代码质量。
