# My Company Plugin

Comprehensive workflow toolkit for managing company structure, employees, development workflows, and project automation.

## Overview

The **my-company** plugin provides a complete suite of tools for managing development workflows, company structure, and project automation in Claude Code. It includes specialized agents, commands, skills, and automation hooks to streamline your development process.

## Features

### 🤖 Agents (5)
- **smart-compact-agent**: Intelligent context compression and cleanup
- **web-browser**: Web browsing and information retrieval
- **code-explorer**: Code search and navigation specialist
- **doc-writer**: Documentation creation and maintenance
- **context-manager**: Development context lifecycle management

### ⚡ Commands (4)
- **session-compact**: Execute intelligent compression and cleanup
- **checkpoint**: Create and manage development checkpoints
- **project-init**: Initialize project with optimized setup
- **load-test-engineer-王麻子**: Activate test engineer employee

### 📚 Skills (11)
- **agent-creator**: Create Claude Code subagents
- **architecture-generator**: Generate project architecture documentation
- **context-engineering**: Manage development contexts
- **fire-employee**: Remove employee profiles
- **hire-employee**: Create employee profiles from position templates
- **lsp-usage**: LSP installation and configuration guide
- **permission-usage**: Claude Code permissions configuration
- **personality-creator**: Create personality templates
- **position-creator**: Create position templates
- **serena-mcp**: Serena MCP semantic coding tools
- **tdd-workflow**: Test-driven development workflow

### 🔧 Automation
- **Hooks**: Event-driven automation for workflow optimization
- **MCP Integration**: Serena MCP for semantic code understanding

### 📋 Development Rules
- Coding style guidelines
- Git workflow standards
- Testing requirements
- Performance optimization
- Common patterns
- Security guidelines
- Agent orchestration
- Context engineering

## Installation

### Option 1: Use Plugin Directory
```bash
cc --plugin-dir /Users/wuchaoli/codespace/workflow-dev
```

### Option 2: Copy to Global Plugins
```bash
cp -r /Users/wuchaoli/codespace/workflow-dev ~/.claude/plugins/my-company
```

### Option 3: Symlink for Development
```bash
ln -s /Users/wuchaoli/codespace/workflow-dev ~/.claude/plugins/my-company
```

## Prerequisites

- Claude Code CLI installed
- Node.js (for certain skills)
- Git (for version control features)
- Serena MCP server (optional, for semantic code features)

## Usage

### Using Commands
```bash
# Initialize a new project
/project-init

# Create a checkpoint
/checkpoint

# Compress session context
/session-compact

# Load employee profile
/load-test-engineer-王麻子
```

### Using Skills
Skills are automatically triggered based on user queries:
- Ask about "creating an agent" → triggers agent-creator skill
- Ask about "architecture documentation" → triggers architecture-generator skill
- Mention "context management" → triggers context-engineering skill
- Ask about "LSP configuration" → triggers lsp-usage skill

### Using Agents
Agents are invoked automatically or explicitly:
- Code exploration tasks → code-explorer agent
- Documentation updates → doc-writer agent
- Context management → context-manager agent
- Web research → web-browser agent

## Company Management

This plugin includes a company management system:

### Employee Management
1. **Create Position Templates**: Use position-creator skill
2. **Hire Employees**: Use hire-employee skill to create employee profiles
3. **Activate Employees**: Use load commands to activate employee personas
4. **Fire Employees**: Use fire-employee skill to remove profiles

### Directory Structure
```
.company/
├── position/     # Position templates
└── employee/     # Employee profiles
```

## Configuration

### MCP Server (Optional)
The plugin includes Serena MCP integration. Configure in `.mcp.json`:
```json
{
  "mcpServers": {
    "serena": {
      "command": "serena-mcp",
      "args": []
    }
  }
}
```

### Plugin Settings
Create `.claude/my-company.local.md` for project-specific settings (if needed).

## Development Rules

The plugin includes comprehensive development rules in the `rules/` directory:
- **coding-style.md**: Immutability, file organization, error handling
- **git-workflow.md**: Commit messages, PR workflow, feature implementation
- **testing.md**: TDD requirements, 80% coverage minimum
- **performance.md**: Model selection, context management
- **patterns.md**: API responses, custom hooks, repository pattern
- **hooks.md**: Hook types and best practices
- **agents.md**: Agent orchestration and usage
- **security.md**: Security checks and secret management
- **context-engineering.md**: Document management system

## Examples

### Example 1: Initialize New Project
```bash
/project-init
```
This will set up optimized permissions, context structure, and tooling.

### Example 2: Create Employee Profile
1. Ask: "Help me create a position template for a senior developer"
2. Ask: "Hire an employee named John from the senior-developer position"
3. Use: `/load-john` to activate the employee

### Example 3: Generate Architecture Documentation
Ask: "Generate architecture documentation for this project"
The architecture-generator skill will be triggered automatically.

## Troubleshooting

### Plugin Not Loading
- Verify `.claude-plugin/plugin.json` exists
- Check plugin directory path is correct
- Restart Claude Code session

### Commands Not Appearing
- Run `/help` to see available commands
- Ensure commands have proper YAML frontmatter
- Check command files are in `commands/` directory

### Skills Not Triggering
- Use specific trigger phrases from skill descriptions
- Check skill files have proper structure
- Verify skills are in `skills/` directory

## Contributing

This plugin is under active development. To add new components:
1. Add agents to `agents/`
2. Add commands to `commands/`
3. Add skills to `skills/`
4. Update this README

## License

[Specify your license]

## Support

For issues or questions, please refer to the project documentation or contact the maintainer.
