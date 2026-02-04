# 文件结构

## 统计信息

- **总文件数**: 101
- **扫描深度**: 无限制

## 文件类型分布

| 扩展名 | 文件数 |
|--------|--------|

| `.md` | 76 |

| `.py` | 11 |

| `.j2` | 4 |

| `.skill` | 4 |

| `.sh` | 3 |

| `.json` | 2 |

| `` | 1 |


## 文件树

```
workflow-dev/
├── agents/
│   ├── code-explorer.md
│   ├── context-manager.md
│   └── doc-writer.md
├── archive/
│   ├── agents/
│   │   ├── code-architect.md
│   │   ├── code-new-requirement.md
│   │   ├── code-planner.md
│   │   ├── code-refactor.md
│   │   └── code-tdd-dev.md
│   └── commands/
│       ├── architect.md
│       ├── context-archive.md
│       ├── context-init.md
│       ├── context-manage.md
│       └── workflow-dev.md
├── commands/
│   └── checkpoint.md
├── .company/
│   ├── employee/
│   ├── personality/
│   │   └── analytical-type.md
│   └── position/
│       └── test-engineer.md
├── docs/
│   ├── architecture/
│   │   ├── dependencies/
│   │   │   └── level-0.md
│   │   ├── README.md
│   │   ├── file-structure.md
│   │   └── symbols-index.md
│   ├── contexts/
│   │   └── README.md
│   ├── static/
│   │   ├── api/
│   │   ├── architecture/
│   │   ├── data-flow/
│   │   ├── development/
│   │   │   ├── context-engineering-spec.md
│   │   │   ├── context-engineering-templates.md
│   │   │   ├── dev-workflow-guide.md
│   │   │   └── workflow-checkpoint-integration.md
│   │   ├── user-journey/
│   │   └── README.md
│   ├── IMPLEMENTATION_SUMMARY.md
│   └── QUICK_REFERENCE.md
├── plugin/
│   ├── commands/
│   │   ├── agent-creator.md
│   │   ├── context-archive.md
│   │   ├── context-init.md
│   │   └── context-manage.md
│   ├── README.md
│   └── plugin.json
├── rules/
│   └── context-engineering.md
├── session-memory/
│   ├── commands/
│   ├── hooks/
│   │   ├── scripts/
│   │   │   ├── load-session.sh
│   │   │   ├── save-before-clear.sh
│   │   │   └── save-session.sh
│   │   └── hooks.json
│   ├── .gitignore
│   ├── PROGRESS.md
│   └── README.md
├── skills/
│   ├── agent-creator/
│   │   ├── assets/
│   │   │   └── agent-template.md
│   │   ├── references/
│   │   │   ├── agent-examples.md
│   │   │   ├── agent-examples_zh.md
│   │   │   ├── best-practices.md
│   │   │   ├── best-practices_zh.md
│   │   │   ├── frontmatter-fields.md
│   │   │   └── frontmatter-fields_zh.md
│   │   └── SKILL.md
│   ├── architecture-generator/
│   │   ├── assets/
│   │   │   └── templates/
│   │   │       ├── README.md.j2
│   │   │       ├── dependency-graph.md.j2
│   │   │       ├── file-structure.md.j2
│   │   │       └── symbols-index.md.j2
│   │   ├── references/
│   │   │   ├── serena-integration.md
│   │   │   └── usage-guide.md
│   │   ├── scripts/
│   │   │   ├── __pycache__/
│   │   │   ├── analyze_dependencies.py
│   │   │   ├── build_symbol_index.py
│   │   │   ├── config_manager.py
│   │   │   ├── generate.py
│   │   │   ├── incremental_scanner.py
│   │   │   ├── query_index.py
│   │   │   ├── scan_file_structure.py
│   │   │   └── utils.py
│   │   └── SKILL.md
│   ├── context-engineering/
│   │   ├── references/
│   │   │   ├── specification.md
│   │   │   └── templates.md
│   │   ├── scripts/
│   │   │   ├── archive_context.py
│   │   │   ├── init_context.py
│   │   │   └── list_contexts.py
│   │   └── SKILL.md
│   ├── fire-employee/
│   │   ├── references/
│   │   │   └── deletion-guide.md
│   │   └── SKILL.md
│   ├── hire-employee/
│   │   ├── assets/
│   │   │   └── employee-template.md
│   │   ├── references/
│   │   │   ├── command-guide.md
│   │   │   └── content-guide.md
│   │   └── SKILL.md
│   ├── lsp-usage/
│   │   ├── references/
│   │   │   ├── languages.md
│   │   │   └── troubleshooting.md
│   │   └── SKILL.md
│   ├── personality-creator/
│   │   ├── assets/
│   │   │   └── personality-template.md
│   │   ├── references/
│   │   │   ├── examples.md
│   │   │   └── personality-components.md
│   │   ├── IMPLEMENTATION_SUMMARY.md
│   │   ├── README.md
│   │   └── skill.md
│   ├── position-creator/
│   │   ├── assets/
│   │   │   └── position-template.md
│   │   ├── references/
│   │   │   ├── examples.md
│   │   │   └── position-components.md
│   │   └── SKILL.md
│   ├── serena-mcp/
│   │   ├── references/
│   │   │   ├── client-config.md
│   │   │   ├── full-guide.md
│   │   │   └── tools-reference.md
│   │   └── SKILL.md
│   ├── tdd-workflow/
│   │   └── SKILL.md
│   ├── agent-creator.skill
│   ├── architecture-generator.skill
│   ├── context-engineering.skill
│   └── serena-mcp.skill
├── CLAUDE.md
└── UPDATELOG.md
```

---

## 说明

- 文件树遵循项目的 [`.gitignore`](../../.gitignore) 配置
- 只包含源代码文件，排除构建产物和依赖目录
- 文件按字母顺序排列