# chiki_nvim

A fast, modular Neovim configuration for statistics, data science, academic research, SQL work, and general software development.

The configuration uses `lazy.nvim` directly. It borrows proven architecture and workflow ideas from current LazyVim without depending on the LazyVim distribution itself.

## Requirements

- **Neovim:** `>= 0.11.4`
- **Install path:** `~/.config/nvim`
- **Core CLI tools:** `git`, `ripgrep`, `fd`, `lazygit`
- **Font:** a Nerd Font, e.g. JetBrains Mono Nerd Font
- **Build tools:** GNU `make` and a C compiler (`gcc` or `clang`)
- **SQLite:** `sqlite3` for Dadbod SQLite connections
- **R:** R `>= 4.1.0` plus build tools for `R.nvim`
- **LaTeX:** `latexmk` and `zathura` for the configured VimTeX workflow

Most language servers, formatters, and linters are installed automatically through Mason.

## Language & Workflow Stack

| Area | Intelligence / Diagnostics | Formatting | Extra workflow |
|---|---|---|---|
| **Lua** | `lua_ls`, `lazydev.nvim` | `stylua` | Neovim API-aware completion |
| **Python** | `basedpyright` + `ruff` | `ruff_format` | `venv-selector.nvim` for per-project environments |
| **Rust** | `rustaceanvim` / `rust-analyzer`, `bacon-ls` | `rustfmt` | `crates.nvim` for Cargo dependencies; Taplo for TOML |
| **R / Statistics** | `R.nvim` / `rnvimserver` | R workflow | interactive console, object browser, Rmd / Quarto support |
| **Markdown** | `marksman` | LSP / project tooling | `render-markdown.nvim` |
| **JavaScript / TypeScript** | `ts_ls`, `eslint` | LSP / Conform fallback | HTML, CSS, JSON and Emmet support |
| **C / C++** | `clangd` | manual / LSP | systems development |
| **Go** | `gopls` | LSP | Go development |
| **JSON / YAML** | `jsonls`, `yamlls` + `SchemaStore.nvim` | LSP | schema-aware validation and completion |
| **TOML** | `taplo` | LSP | Cargo/TOML intelligence |
| **Docker** | `dockerls`, Docker Compose language service | LSP | Docker configuration |
| **SQL** | Dadbod completion + `sqlfluff` diagnostics | `sqlfluff` | DB browser, saved queries, execution and schema completion |
| **LaTeX / BibTeX** | `texlab` + VimTeX | VimTeX / LaTeX tooling | Zathura, latexmk, LuaSnip math snippets |

### Python

Python deliberately runs two complementary LSPs:

- **basedpyright** owns type analysis and hover information.
- **Ruff** owns fast linting and code actions; Ruff hover is disabled to avoid duplicate UI.

Use:

```text
<leader>cv    Select / activate a Python virtual environment
```

The selected environment is applied to the Neovim process and Python LSP workflow.

### Rust / Cargo

Rust diagnostics are split intentionally:

- `rust-analyzer` / Rustaceanvim provides language intelligence.
- `bacon-ls` owns Cargo diagnostics.
- `crates.nvim` adds dependency/version intelligence inside `Cargo.toml`.
- `taplo` provides TOML language support.

## Database / SQL Workflow

Dadbod is integrated directly with Blink completion:

```text
<leader>db    Toggle Database UI
<leader>da    Add a database connection
<leader>df    Find the current database buffer
```

For SQLite:

```text
sqlite:/absolute/path/to/database.sqlite
```

SQL buffers receive table and column completion from the active Dadbod connection. Neovim's legacy SQL omni-completion is disabled so it does not compete with Blink/Dadbod.

DBUI query buffers do **not** execute automatically when saved. Execute deliberately with Dadbod UI's buffer-local:

```text
<leader>S     Execute query / selection
```

### SQLFluff dialect selection

SQL linting and formatting share `lua/config/sql.lua` so they always use the same dialect policy:

1. If the project explicitly specifies `dialect = ...` in `.sqlfluff`, `pyproject.toml`, `setup.cfg`, or `tox.ini`, SQLFluff is allowed to use that project setting.
2. Otherwise, an active Dadbod connection is inspected (`sqlite:`, `postgres:`, `mysql:`, `duckdb:`, etc.).
3. `mysql` and `plsql` filetypes provide a fallback hint.
4. Plain `.sql` with no other context falls back to ANSI SQL.

This means a Chinook-style SQLite connection automatically gets SQLite-aware SQLFluff behavior without making the entire config SQLite-specific.

## Editing & Navigation

The config intentionally consolidates overlapping functionality:

- `Snacks.words` owns LSP reference highlighting/navigation.
- `mini.diff` owns lightweight Git hunk visualization.
- `mini.icons` supplies the devicons-compatible API, so a separate `nvim-web-devicons` plugin is unnecessary.
- `mini.splitjoin` replaces the previous Treesj dependency while keeping the existing mappings:

```text
<leader>jm    Toggle split / join
<leader>jj    Join arguments
<leader>js    Split arguments
```

`mini.operators` keeps Neovim 0.11+'s native `gr*` LSP mappings and core editing prefixes intact. Its replace operator uses the leader namespace:

```text
<leader>r{motion}    Replace text covered by a motion with a register
<leader>rr           Replace the current line
```

Project-wide interactive search/replace:

```text
<leader>sr    Open Grug Far
```

Aerial remains available but is loaded only when requested:

```text
<leader>oa    Toggle outline
<leader>os    Search symbols through Aerial / Snacks
```

For LaTeX, `K` is left available to Texlab/LSP hover and VimTeX package docs are moved to:

```text
<leader>K     VimTeX package documentation
```

## Structure

```text
~/.config/nvim/
├── init.lua
├── lua/
│   ├── config/
│   │   ├── lazy.lua          # lazy.nvim bootstrap + automatic plugin-spec import
│   │   ├── options.lua       # Core editor/environment options
│   │   ├── keymaps.lua       # Global mappings
│   │   ├── autocmds.lua      # Core lifecycle/filetype behavior
│   │   ├── sql.lua           # Shared SQLFluff dialect resolution
│   │   └── plugins/          # Modular lazy.nvim plugin specs
│   └── snippets/
│       └── tex.lua           # LuaSnip LaTeX snippets
└── lazy-lock.json
```

Every file under `lua/config/plugins/` is discovered automatically. Adding a plugin spec does not require editing `lazy.lua`.

## Performance Design

- Core Neovim options initialize before eager plugins.
- Plugin specs are auto-imported and expensive plugins are loaded by filetype, command, key, or editing event where practical.
- `Snacks.bigfile` is the **single** large-file gate; there is no competing low Treesitter size threshold.
- Treesitter loads only for real files, not the empty dashboard path.
- VimTeX owns LaTeX syntax highlighting rather than running a second Treesitter highlighter on top of it.
- Aerial, Colorizer, Render Markdown, Dadbod, SQL linting, venv selection, Crates and Grug Far are demand/filetype loaded.
- No duplicate Fidget/Noice LSP progress stack.
- No duplicate cursorword/manual LSP reference-highlighting stack.
- No duplicate icon provider.
- Unused built-in runtime archive/tutorial plugins are disabled.

To inspect startup cost with the existing Snacks profiler hook:

```bash
PROF=1 nvim
```

After pulling configuration/plugin changes, run once:

```vim
:Lazy sync
:checkhealth
```
