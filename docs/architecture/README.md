# workflow-dev 架构文档

生成时间: 2026-02-03 14:35:24
项目路径: /Users/wuchaoli/codespace/workflow-dev

---

## 概述

本文档由 `architecture-generator` 技能自动生成，包含项目的架构信息：

- **总文件数**: 101
- **主要语言**:

  - `.md`: 76 个文件

  - `.py`: 11 个文件

  - `.j2`: 4 个文件

  - `.skill`: 4 个文件

  - `.sh`: 3 个文件

  - `.json`: 2 个文件

  - ``: 1 个文件


---

## 快速导航

- [文件结构](./file-structure.md) - 完整的项目文件树
- [依赖关系](./dependencies/level-0.md) - 模块和文件之间的依赖关系
- [符号索引](./symbols-index.md) - 代码符号（类、函数）索引

---

## 如何使用本文档

### 理解项目结构

1. 阅读 [文件结构](./file-structure.md) 了解项目的组织方式
2. 查看 [依赖关系图](./dependencies/level-0.md) 理解模块之间的依赖
3. 使用 [符号索引](./symbols-index.md) 查找特定的类和函数

### 代码导航

```bash
# 查找符号
cd /Users/wuchaoli/codespace/workflow-dev
python .architecture-generator/query_index.py . find <symbol-name>

# 搜索符号
python .architecture-generator/query_index.py . search <keyword>

# 查看文件的符号
python .architecture-generator/query_index.py . file <file-path>
```

---

## 项目信息

- **根目录**: `/Users/wuchaoli/codespace/workflow-dev`
- **架构文档目录**: `docs/architecture`
- **符号索引数据库**: `docs/architecture/.cache/symbols.db`

---

*本文档由 [architecture-generator](https://github.com/your-repo/architecture-generator) 技能自动生成*