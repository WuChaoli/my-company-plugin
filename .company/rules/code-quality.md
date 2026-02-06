# 代码质量规范

## 核心原则

**代码质量是长期可维护性的基础，而非可选项**

---

## 绝对禁令

| 禁令 | 反例 | 正例 |
|------|------|------|
| **禁止突变** | `user.name = value` | `{...user, name: value}` |
| **禁止硬编码密钥** | `const key = "sk-xxx"` | `process.env.API_KEY` |
| **禁止忽略错误** | `fn()` 不检查返回 | `try { fn() } catch { ... }` |
| **禁止跳过输入验证** | 直接使用用户输入 | 使用 Zod/类型系统验证 |
| **禁止跳过错误处理** | 内部抛出但端点不捕获 | 端点必须捕获并处理 |
| **禁止 console.log** | 生产代码中调试 | 使用日志系统 |
| **禁止跳过安全检查** | 提交前不检查 | SQL注入、XSS、CSRF必须防护 |

---

## 必须遵守

### 不可变性（IMMUTABILITY）

**最高优先级**

```javascript
// ❌ 错误：修改原对象
function updateUser(user, name) {
  user.name = name  // MUTATION!
  return user
}

// ✅ 正确：创建新对象
function updateUser(user, name) {
  return {
    ...user,
    name
  }
}
```

- [ ] 永远创建新对象
- [ ] 永远不修改原对象
- [ ] 使用展开运算符、Object.freeze 等

### 函数大小

- [ ] **≤30 行**：单一原子操作
- [ ] **复杂逻辑提取为函数**：用函数名替代注释
- [ ] **单一职责**：一个函数只做一件事

### 文件大小

- [ ] **200-400 行**：典型大小
- [ ] **≤800 行**：最大限制
- [ ] **高内聚低耦合**：按功能/域组织
- [ ] **提取工具函数**：从大组件中提取

### 嵌套深度

- [ ] **≤4 层**：最大嵌套深度
- [ ] **提前返回**：避免深层嵌套
- [ ] **提取函数**：复杂条件逻辑

### 错误处理

- [ ] **必须处理**：所有可能失败的调用
- [ ] **内部抛出，端点捕获**：分层错误处理
- [ ] **友好错误消息**：面向用户的清晰说明
- [ ] **记录日志**：技术细节用于调试

```typescript
// 正确示例
async function updateUser(id: string, data: UserData) {
  try {
    const result = await riskyOperation()
    return result
  } catch (error) {
    console.error('Operation failed:', error)
    throw new Error('Failed to update user profile')
  }
}
```

### 输入验证

- [ ] **必须验证**：所有系统边界的输入
- [ ] **使用类型系统**：Zod、TypeScript 等
- [ ] **早期失败**：验证失败立即返回

```typescript
import { z } from 'zod'

const schema = z.object({
  email: z.string().email(),
  age: z.number().int().min(0).max(150)
})

const validated = schema.parse(input)
```

### 测试要求

- [ ] **覆盖率 ≥80%**：单元 + 集成 + E2E
- [ ] **TDD 流程**：RED → GREEN → REFACTOR
- [ ] **测试类型**：
  - 单元测试：函数、工具、组件
  - 集成测试：API 端点、数据库操作
  - E2E 测试：关键用户流程

### 安全要求

- [ ] **禁止硬编码密钥**：API keys, passwords, tokens
- [ ] **输入验证**：所有用户输入必须验证
- [ ] **SQL 注入防护**：使用参数化查询
- [ ] **XSS 防护**：HTML 净化
- [ ] **CSRF 保护**：开启 CSRF 令牌
- [ ] **鉴权/授权**：验证用户身份和权限
- [ ] **端点限流**：防止 DDoS
- [ ] **错误信息安全**：不泄露敏感数据

```typescript
// ✗ 错误
const apiKey = "sk-proj-xxxxx"

// ✓ 正确
const apiKey = process.env.OPENAI_API_KEY
if (!apiKey) {
  throw new Error('OPENAI_API_KEY not configured')
}
```

---

## 推荐做法

### 设计原则

- **YAGNI**（You Aren't Gonna Need It）
  - 猛烈删除不必要的功能
  - 不要为未来编码

- **DRY**（Don't Repeat Yourself）
  - 提取公共逻辑
  - 创建可复用函数

- **KISS**（Keep It Simple, Stupid）
  - 保持代码简洁
  - 避免过度设计

### 代码组织

- **多小文件 > 少大文件**
  - 200-400 行典型
  - 按功能/域组织，不按类型

- **高内聚低耦合**
  - 相关功能聚合
  - 模块间最小依赖

- **清晰的命名**
  - 函数名描述行为
  - 变量名描述内容
  - 避免缩写（除非通用）

### 注释规范

- **代码自解释优先**
  - 好的命名 > 注释
  - 复杂逻辑才需注释

- **中文注释**
  - 类开头：功能说明
  - 函数开头：目的、参数、返回
  - 复杂操作：逻辑解释

```javascript
/**
 * 用户认证服务
 * 处理用户登录、注册、token 验证
 */
class AuthService {
  /**
   * 验证用户凭证
   * @param {string} email - 用户邮箱
   * @param {string} password - 用户密码
   * @returns {Promise<boolean>} - 验证是否成功
   */
  async verifyCredentials(email, password) {
    // 实现...
  }
}
```

---

## 代码风格

### 默认风格

**如无指定，使用 Google 代码风格**

### 语言特定

- **JavaScript/TypeScript**
  - 2 空格缩进
  - 单引号优先
  - 尾随逗号
  - 无分号（可选）

- **Python**
  - 4 空格缩进
  - PEP 8 风格
  - 类型提示

- **Go**
  - tab 缩进
  - gofmt 格式化
  - 错误处理必须显式

---

## 提交前检查清单

### 代码质量

- [ ] 无修改操作（不可变性）
- [ ] 无 console.log
- [ ] 无硬编码值
- [ ] 函数 ≤30 行
- [ ] 文件 ≤800 行
- [ ] 嵌套 ≤4 层
- [ ] 错误已处理
- [ ] 输入已验证

### 测试

- [ ] 单元测试通过
- [ ] 集成测试通过
- [ ] E2E 测试通过（关键流程）
- [ ] 测试覆盖率 ≥80%

### 安全

- [ ] 无硬编码密钥
- [ ] 所有输入已验证
- [ ] SQL 注入防护
- [ ] XSS 防护
- [ ] CSRF 保护
- [ ] 鉴权/授权验证
- [ ] 端点限流
- [ ] 错误信息安全

### 文档

- [ ] 复杂逻辑有注释
- [ ] 公共 API 有文档
- [ ] 设计文档更新（如适用）

### Git

- [ ] 提交消息清晰
- [ ] 遵循 conventional commits
- [ ] 无大文件/敏感文件
- [ ] 分支名称清晰

---

## 常见错误认知

| 错误认知 | 真相 |
|---------|------|
| "这个修改很安全" | 任何修改都违反不可变性原则 |
| "console.log 调试很方便" | 生产代码不应有调试语句 |
| "硬编码这次没关系" | 硬编码值迟早会出问题 |
| "函数长点没关系" | 长函数难以理解和测试 |
| "错误处理以后加" | 以后永远不会加 |
| "测试后写也一样" | 测试后写=验证行为，测试前写=定义行为 |

---

## 红旗警告

**当你出现以下想法时，立即停止并遵循规则：**

- "就改这一处对象"
- "这个 console.log 有用"
- "这个值不会变，硬编码"
- "这个函数虽然长但逻辑清晰"
- "先不加错误处理，以后再说"
- "输入应该是对的，不验证了"
- "安全检查太麻烦，这次跳过"

---

## 安全响应协议

发现安全问题：
1. 立即停止
2. 使用 **security-reviewer** agent
3. 修复 CRITICAL 问题后继续
4. 轮换暴露的密钥
5. 全库排查类似问题

---

## 测试故障排除

1. 使用 **tdd-guide** agent
2. 检查测试隔离
3. 验证 mocks 正确性
4. 修复实现，非测试（除非测试错误）

---

**规范版本**: 3.0
**最后更新**: 2026-02-05
**变更**: 整合 security.md 和 testing.md，移除冗余的开发流程内容
