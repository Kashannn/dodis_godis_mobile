# 🤖 Serena Project Configuration & Memories

Official Documentation: [https://oraios.github.io/serena/](https://oraios.github.io/serena/01-about/000_intro.html)  
Repository: [https://github.com/oraios/serena](https://github.com/oraios/serena)

---

## 📌 About This Folder

This `.serena/` directory contains configuration, local cache instructions, and persistent semantic memories for **Serena**, the MCP (Model Context Protocol) coding agent toolkit developed by Oraios AI.

Instead of reading all files into context repeatedly, Serena uses this directory to maintain:
1. `project.yml`: Core project-level configuration and Dart Language Server bindings.
2. `memories/`: Markdown memories that give AI agents instant architectural and convention context without token wastage.

---

## 📂 Directory Structure

```
.serena/
├── project.yml                 # Serena project-level configuration
├── README.md                   # This documentation file
└── memories/                   # Persistent context memories for AI agents
    ├── architecture.md         # Clean Architecture & state management overview
    ├── codebase_overview.md    # Map of all directories, screens, and features
    ├── conventions.md          # Coding style, AppCustomScaffold, and design tokens
    └── game_rules_flow.md      # Game rules logic (Dodis Game, Yatzy, Date Cards)
```

---

## 🚀 Running Serena MCP Server

### Run with `uvx` (Recommended, no installation required):
```bash
uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide --project .
```

### Install with `uv tool`:
```bash
uv tool install -p 3.13 serena-agent@latest --prerelease=allow
serena init
serena start-mcp-server --context ide --project .
```

### Connect to Claude Code:
```bash
claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context claude-code --project "$(pwd)"
```
