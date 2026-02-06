# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added - 2026-02-06

#### Employee Management System
- **Employee Registry** (`.company/employee/`)
  - New registry system for managing employee profiles
  - Created 5 specialized employee profiles with personality templates:
    - `architect-师爷` - Architecture design and system planning
    - `refactor-engineer-罗辑` - Code refactoring and optimization
    - `requirement-planner-造梦` - Requirement analysis and planning
    - `tdd-developer-鲁班` - Test-driven development
    - `test-engineer-王麻子` - Quality assurance and testing
  - Each employee profile includes position reference and personality definition

#### Employee Activation Commands
- **Load Commands** (`commands/load-*.md`)
  - `load-architect-师爷.md` - Activate architect employee
  - `load-refactor-engineer-罗辑.md` - Activate refactor engineer
  - `load-requirement-planner-造梦.md` - Activate requirement planner
  - `load-tdd-developer-鲁班.md` - Activate TDD developer
  - `load-test-engineer-王麻子.md` - Activate test engineer

#### Position Templates Enhancement
- **Updated Position Definitions** (`.company/position/`)
  - `architect.md` - Enhanced with comprehensive responsibilities and skills
  - `refactor-engineer.md` - Refined scope and tool requirements
  - `requirement-planner.md` - Improved planning methodology
  - `tdd-developer.md` - Strengthened TDD practices
  - `test-engineer.md` - Expanded testing strategies

#### New Skills

**Doc Location Manager** (`skills/doc-location-manager/`)
- Document location management system for organizing project documentation
- Two-tier architecture: static docs (`docs/static/`) and dynamic contexts (`docs/contexts/`)
- Features: document indexing, metadata management, archive workflow

**Context Engineering** (`skills/context-engineering/`)
- Development context management system
- Initialize context for new features, track active work, archive completed features
- Structured workflow for context lifecycle management

**LSP Setup** (`skills/lsp-setup/`)
- LSP installation, configuration, and usage guide
- Semantic-level code understanding capabilities (jump to definition, find references)
- Troubleshooting and language-specific setup guides

#### Enhanced Skills

**Architecture Generator** (`skills/architecture-generator/`)
- Enhanced Python AST extractor with advanced features
- New extractor modules:
  - `class_extractor.py` - Class analysis with decorators and inheritance
  - `function_extractor.py` - Function analysis with async/generator support
  - `dependency_extractor.py` - Import and dependency mapping
  - `call_graph_builder.py` - Function call relationship analysis
  - `pattern_extractor.py` - Design pattern detection
  - `variable_extractor.py` - Variable scope and usage tracking
- Enhanced symbol index builder with incremental scanning
- Comprehensive test suite with 400+ lines of test cases
- Test coverage for all extractor modules with example samples

**Hire Employee** (`skills/hire-employee/`)
- Streamlined employee creation workflow from position templates
- Automatic command generation for employee activation
- Enhanced template structure with personality integration

**Position Creator** (`skills/position-creator/`)
- Simplified position template creation (305 → ~200 lines)
- Streamlined template structure for better maintainability
- Clear guidelines for position definition (max 800 words)

### Changed - 2026-02-06

#### Document Structure Refactoring
- Removed standalone `.skill` files, migrated to folder-based structure
- Consolidated personality definitions into employee profiles
- Removed duplicate `personality/` directory, integrated into employee system

#### File Organization
- Removed binary `.skill` files in favor of markdown-based `SKILL.md` files
- Enhanced skill folders with supporting documentation and references
- Improved organization of architecture-generator scripts and tests

### Removed - 2026-02-06

- `claude-code-permissions-settings.png` - Binary screenshot file
- `.company/personality/README.md` - Superseded by employee profile system
- `agents/doc-writer.md` - Deprecated
- `agents/smart-compact-agent.md` - Deprecated
- `hooks/` directory - Moved to employee-specific configurations
- `rules/` directory - Reorganized into employee and position templates

### Technical Improvements

- **Python AST Analysis**: Enhanced with 10+ programming language support
- **Dependency Mapping**: Automatic extraction of module dependencies and call graphs
- **Test Coverage**: Added comprehensive test suite for architecture generator
- **Documentation**: Improved Chinese localization for employee management system
- **Modular Design**: Separated concerns into distinct extractors for better maintainability

---

## [0.1.0] - 2026-02-03

### Added
- Initial project structure
- Basic position templates
- Core skill definitions
- Employee management foundation

---

**Note**: Version numbers follow semantic versioning. Changes are categorized as:
- **Added**: New features
- **Changed**: Changes to existing functionality
- **Deprecated**: Soon-to-be removed features
- **Removed**: Removed features
- **Fixed**: Bug fixes
- **Security**: Security vulnerability fixes
