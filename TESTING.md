# Plugin Testing Checklist

## Plugin: my-company v0.1.0

### Pre-Testing Setup

✅ Plugin structure created with `.claude-plugin/plugin.json`
✅ All components verified (5 agents, 4 commands, 11 skills, hooks, MCP)
✅ Validation passed with warnings addressed
✅ Cache files cleaned up
✅ Hook scripts made executable

### Testing Instructions

#### 1. Verify Plugin Loading

**Current Session Test:**
Since you're already in the plugin directory (`/Users/wuchaoli/codespace/workflow-dev`), the plugin should be automatically loaded.

**Alternative Test Methods:**
```bash
# Option A: Use plugin directory flag
cc --plugin-dir /Users/wuchaoli/codespace/workflow-dev

# Option B: Copy to global plugins
cp -r /Users/wuchaoli/codespace/workflow-dev ~/.claude/plugins/my-company

# Option C: Symlink for development
ln -s /Users/wuchaoli/codespace/workflow-dev ~/.claude/plugins/my-company
```

#### 2. Test Commands

Run `/help` to see if commands are available:

- [ ] `/checkpoint` - Create development checkpoint
- [ ] `/project-init` - Initialize project
- [ ] `/session-compact` - Compress session context
- [ ] `/load-test-engineer-王麻子` - Load employee profile

**Test each command:**
```bash
# Test checkpoint
/checkpoint

# Test project-init (be careful, this modifies project structure)
# /project-init

# Test session-compact
/session-compact

# Test employee loading
/load-test-engineer-王麻子
```

#### 3. Test Skills

Skills trigger automatically based on user queries. Test with these phrases:

- [ ] **agent-creator**: "How do I create a new agent?"
- [ ] **architecture-generator**: "Generate architecture documentation"
- [ ] **context-engineering**: "Help me manage development contexts"
- [ ] **hire-employee**: "I want to hire a new employee"
- [ ] **fire-employee**: "How do I remove an employee?"
- [ ] **permission-usage**: "How do I configure Claude Code permissions?"
- [ ] **serena-mcp**: "How do I use Serena MCP for code navigation?"
- [ ] **lsp-usage**: "How do I set up LSP for Python?"
- [ ] **position-creator**: "Create a position template for a developer"
- [ ] **personality-creator**: "Create a personality template"
- [ ] **tdd-workflow**: "Help me write tests for this feature"

#### 4. Test Agents

Agents should trigger automatically or can be invoked explicitly:

- [ ] **code-explorer**: Ask "Find all functions that use the API"
- [ ] **doc-writer**: Ask "Update the documentation for this module"
- [ ] **context-manager**: Ask "Initialize a new development context"
- [ ] **web-browser**: Ask "Search for information about X"
- [ ] **smart-compact-agent**: Should trigger when context is full

#### 5. Test Hooks

Hooks run automatically on events:

- [ ] **SessionStart**: Check if session loads properly (load-session.sh)
- [ ] **PostToolUse**: Check if context monitoring works (check-context.sh)

To verify hooks are working:
```bash
# Check hook execution in debug mode
cc --debug
```

#### 6. Test MCP Integration

Verify Serena MCP is configured:

- [ ] Check if Serena MCP server is available
- [ ] Test semantic code navigation features
- [ ] Verify LSP integration works

#### 7. Test Company Management

Test the company management features:

- [ ] List positions: `ls .company/position/`
- [ ] List personalities: `ls .company/personality/`
- [ ] List employees: `ls .company/employee/`
- [ ] Create new position (use position-creator skill)
- [ ] Hire employee (use hire-employee skill)
- [ ] Load employee profile (use load command)
- [ ] Fire employee (use fire-employee skill)

#### 8. Test Rules

Rules should be automatically applied:

- [ ] Verify coding style rules are followed
- [ ] Check git workflow guidance
- [ ] Confirm testing requirements are enforced
- [ ] Validate security guidelines are applied

### Expected Results

#### ✅ Success Indicators

1. **Commands appear in `/help`** output
2. **Skills trigger** when using trigger phrases
3. **Agents activate** for appropriate tasks
4. **Hooks execute** on events (check logs)
5. **MCP server connects** (if Serena is installed)
6. **Company management** commands work
7. **No error messages** during plugin loading

#### ❌ Failure Indicators

1. Commands not showing in `/help`
2. Skills not triggering on appropriate queries
3. Agents not activating
4. Hook errors in logs
5. MCP connection failures
6. Missing component errors

### Troubleshooting

#### Plugin Not Loading
```bash
# Check if .claude-plugin/plugin.json exists
ls -la .claude-plugin/

# Verify JSON syntax
cat .claude-plugin/plugin.json | python -m json.tool

# Check Claude Code version
cc --version
```

#### Commands Not Appearing
```bash
# Verify command files exist
ls -la commands/

# Check command frontmatter
head -10 commands/checkpoint.md
```

#### Skills Not Triggering
```bash
# Verify skill files exist
ls -la skills/*/SKILL.md

# Check skill descriptions
grep "description:" skills/*/SKILL.md
```

#### Hooks Not Working
```bash
# Verify hooks.json syntax
cat hooks/hooks.json | python -m json.tool

# Check script permissions
ls -la hooks/scripts/

# Make scripts executable if needed
chmod +x hooks/scripts/*.sh
```

#### MCP Connection Issues
```bash
# Check .mcp.json configuration
cat .mcp.json

# Verify Serena is installed
which serena

# Test Serena manually
serena --version
```

### Test Results

**Date**: _____________
**Tester**: _____________
**Claude Code Version**: _____________

| Component | Status | Notes |
|-----------|--------|-------|
| Plugin Loading | ⬜ Pass / ⬜ Fail | |
| Commands (4) | ⬜ Pass / ⬜ Fail | |
| Skills (11) | ⬜ Pass / ⬜ Fail | |
| Agents (5) | ⬜ Pass / ⬜ Fail | |
| Hooks (2) | ⬜ Pass / ⬜ Fail | |
| MCP Integration | ⬜ Pass / ⬜ Fail | |
| Company Management | ⬜ Pass / ⬜ Fail | |
| Rules | ⬜ Pass / ⬜ Fail | |

**Overall Status**: ⬜ Pass / ⬜ Fail

**Issues Found**:
1. _____________________________________________
2. _____________________________________________
3. _____________________________________________

**Recommendations**:
1. _____________________________________________
2. _____________________________________________
3. _____________________________________________

---

## Quick Verification Commands

Run these commands to quickly verify the plugin structure:

```bash
# Verify plugin structure
ls -la .claude-plugin/
cat .claude-plugin/plugin.json

# Count components
echo "Agents: $(ls -1 agents/*.md 2>/dev/null | wc -l)"
echo "Commands: $(ls -1 commands/*.md 2>/dev/null | wc -l)"
echo "Skills: $(ls -1d skills/*/ 2>/dev/null | wc -l)"
echo "Rules: $(ls -1 rules/*.md 2>/dev/null | wc -l)"

# Verify hooks
cat hooks/hooks.json | python -m json.tool
ls -la hooks/scripts/

# Verify MCP
cat .mcp.json | python -m json.tool

# Check company structure
ls -la .company/position/
ls -la .company/personality/
ls -la .company/employee/
```

## Next Steps After Testing

1. **If all tests pass**: Move to Phase 8 (Documentation & Distribution)
2. **If tests fail**: Document issues and fix them
3. **If partial success**: Identify which components need work

---

**Plugin Status**: 🟢 Ready for Testing
