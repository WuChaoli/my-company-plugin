---
description: Commit changes, pull main, push to branch, and create pull request
---

# Git PR Workflow Command

自动化 Git 提交流程：提交更改、拉取 main 分支合并、推送到远程分支并创建 Pull Request。

## Usage

```bash
/git-pr [commit-message]
```

## Arguments

- `commit-message` - 提交消息(可选,默认会生成)

## Workflow

### 1. Commit Changes

如果有未提交的更改,创建提交:

```bash
# 查看当前状态
git status

# 添加所有更改
git add .

# 创建提交
git commit -m "<commit-message>"
```

**Commit Message 规范**:

如果没有提供提交消息,根据更改自动生成:

| 变更类型 | 提交消息格式 | 示例 |
|---------|-------------|------|
| 新功能 | `feat: <description>` | `feat: add user authentication` |
| Bug修复 | `fix: <description>` | `fix: resolve login issue` |
| 重构 | `refactor: <description>` | `refactor: simplify document structure` |
| 文档 | `docs: <description>` | `docs: update API documentation` |
| 测试 | `test: <description>` | `test: add unit tests for AuthService` |
| 样式 | `style: <description>` | `style: format code with prettier` |

### 2. Pull Main Branch

拉取 main 分支并合并到当前分支:

```bash
# 拉取远程 main 分支
git fetch origin main

# 合并 main 到当前分支
git merge origin/main

# 如果有冲突,提示用户解决
if [ $? -ne 0 ]; then
    echo "⚠️  Merge conflict detected. Please resolve conflicts and run /git-pr again."
    exit 1
fi
```

**合并冲突处理**:

如果出现合并冲突:

1. 手动解决冲突文件
2. 运行 `git add <resolved-files>`
3. 运行 `git commit`
4. 重新运行 `/git-pr` 继续流程

### 3. Push to Remote

推送当前分支到远程仓库:

```bash
# 获取当前分支名
CURRENT_BRANCH=$(git branch --show-current)

# 推送到远程
git push -u origin $CURRENT_BRANCH
```

**推送失败处理**:

如果推送失败(远程分支有新提交):

```bash
# 方案 1: 强制推送(谨慎使用)
git push --force-with-lease

# 方案 2: 重新拉取合并
git pull --rebase origin $CURRENT_BRANCH
git push
```

### 4. Create Pull Request

使用 `gh` CLI 创建 Pull Request:

```bash
# 获取分支信息
CURRENT_BRANCH=$(git branch --show-current)
BASE_BRANCH="main"

# 获取最近的提交消息
COMMIT_MESSAGE=$(git log -1 --pretty=%B)

# 获取变更范围
COMMIT_RANGE="origin/main...$CURRENT_BRANCH"

# 生成 PR 描述
PR_BODY=$(cat <<EOF
## Summary
$(git log $COMMIT_RANGE --pretty=format:"- %s" | head -10)

## Changes
$(git diff $COMMIT_RANGE --stat)

## Test plan
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

EOF
)

# 创建 PR
gh pr create \
  --base $BASE_BRANCH \
  --head $CURRENT_BRANCH \
  --title "$COMMIT_MESSAGE" \
  --body "$PR_BODY"
```

## Examples

### Example 1: 基本使用

```bash
/git-pr
```

输出:

```markdown
## Git PR Workflow

### 1. 检查状态
Current branch: feat/user-auth
Upstream: origin/feat/user-auth

Changes:
- Modified: src/services/AuthService.ts
- Modified: test/unit/AuthService.test.ts
- Added: docs/api/authentication.md

### 2. 创建提交
✓ Added 3 files
✓ Commit: "feat: add user authentication"

### 3. 拉取 main 分支
✓ Fetched origin/main
✓ Merged origin/main into feat/user-auth

### 4. 推送到远程
✓ Pushed to origin/feat/user-auth

### 5. 创建 Pull Request
✓ PR created: https://github.com/user/repo/pull/42

PR Info:
- Title: feat: add user authentication
- Branch: feat/user-auth → main
- Status: Open
```

### Example 2: 自定义提交消息

```bash
/git-pr "fix: resolve login timeout issue"
```

输出:

```markdown
## Git PR Workflow

### 1. 检查状态
Current branch: fix/login-timeout
Changes:
- Modified: src/services/LoginService.ts
- Modified: test/unit/LoginService.test.ts

### 2. 创建提交
✓ Commit: "fix: resolve login timeout issue"

### 3-5. Pull, Push, Create PR
✓ Merged origin/main
✓ Pushed to origin/fix/login-timeout
✓ PR created: https://github.com/user/repo/pull/43
```

### Example 3: 处理合并冲突

```bash
/git-pr
```

输出:

```markdown
## Git PR Workflow

### 1-2. 检查和提交
✓ Commit created

### 3. 拉取 main 分支
✓ Fetched origin/main
⚠️  Merge conflict detected

Conflict files:
- src/services/AuthService.ts

解决步骤:
1. 打开冲突文件,查找 <<<<<<< 标记
2. 选择保留的代码版本
3. 删除冲突标记
4. 运行 git add src/services/AuthService.ts
5. 运行 git commit
6. 重新运行 /git-pr 继续流程

参考文档: https://git-scm.com/docs/git-merge
```

### Example 4: 无需提交

```bash
/git-pr
```

输出:

```markdown
## Git PR Workflow

### 1. 检查状态
Current branch: feat/user-auth
No uncommitted changes

### 2. 跳过提交
✓ No commit needed

### 3. 拉取 main 分支
✓ Merged origin/main

### 4. 推送到远程
✓ Pushed to origin/feat/user-auth

### 5. 创建 Pull Request
✓ PR created: https://github.com/user/repo/pull/44
```

## Error Handling

### 错误 1: 未配置 GitHub CLI

```bash
Error: gh CLI not found
Install: https://cli.github.com/
Or: brew install gh
Setup: gh auth login
```

### 错误 2: 分支已存在 PR

```bash
Warning: PR already exists for branch feat/user-auth
Existing PR: https://github.com/user/repo/pull/42
Options:
- Open existing PR to update
- Close existing PR and create new one
```

### 错误 3: 推送失败

```bash
Error: Push failed
Remote has commits that are not present locally

Options:
1. Pull with rebase: git pull --rebase
2. Force push: git push --force-with-lease (use with caution)
3. Fetch and merge: git pull --no-rebase
```

### 错误 4: 未登录 GitHub

```bash
Error: GitHub authentication failed
Run: gh auth login
```

## Configuration

### 默认配置

可以在项目根目录创建 `.git-pr-config.yml` 自定义行为:

```yaml
# .git-pr-config.yml
base_branch: main          # 默认基础分支
auto_commit: true          # 自动提交更改
auto_push: true            # 自动推送
auto_pr: true              # 自动创建 PR
pr_template: .github/PULL_REQUEST_TEMPLATE.md  # PR 模板

# 提交消息配置
commit_types:
  - type: feat
    description: 新功能
  - type: fix
    description: Bug修复
  - type: refactor
    description: 重构
  - type: docs
    description: 文档
  - type: test
    description: 测试
  - type: style
    description: 样式
```

### PR 模板

创建 `.github/PULL_REQUEST_TEMPLATE.md`:

```markdown
## Summary
<!-- 简短描述这个 PR 的目的 -->

## Changes
<!-- 列出主要的更改 -->

- [ ] Breaking change
- [ ] New feature
- [ ] Bug fix
- [ ] Documentation update

## Test plan
<!-- 描述如何测试这些更改 -->

- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Comments added to complex code
- [ ] Documentation updated
- [ ] No new warnings generated
- [ ] Tests added/updated
- [ ] All tests pass
```

## Tips

1. **提交前检查**
   - 确保代码通过所有测试
   - 运行 `git status` 查看更改
   - 使用 `git diff` 预览变更

2. **提交消息规范**
   - 使用 Conventional Commits 格式
   - 保持消息简洁明了
   - 包含必要的上下文信息

3. **合并前准备**
   - 确保本地分支是最新的
   - 解决所有合并冲突
   - 运行完整的测试套件

4. **PR 最佳实践**
   - 提供清晰的描述
   - 关联相关 Issue
   - 添加必要的标签和审查者
   - 确保 CI/CD 通过

5. **安全提示**
   - 不要使用 `git push --force` (除非必要)
   - 使用 `--force-with-lease` 代替
   - 在强制推送前确认远程分支状态

## Arguments

$ARGUMENTS:
- `[commit-message]` - 可选的提交消息,如不提供则自动生成

## Related Commands

- `/checkpoint` - 创建检查点
- `/context-archive` - 归档上下文
- `git commit` - Git 提交命令
- `gh pr create` - GitHub PR 创建命令
