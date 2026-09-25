# chiki_nvim

A fast, modular Neovim configuration for statistics, data science, academic research, SQL work, and general software development.

The configuration is built on [LazyVim](https://www.lazyvim.org/): LazyVim supplies the core plugins, options, autocmds, keymaps and LSP/format/lint plumbing, and this repo only layers personal settings and keymaps on top. Existing personal keymaps take precedence over LazyVim's defaults wherever the two overlap.

## Requirements

- **Neovim:** `>= 0.12` (the pinned VimTeX and rustaceanvim versions require it)
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
- `mini.diff` owns lightweight Git hunk visualization (LazyVim's `editor.mini-diff` extra, replacing gitsigns).
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

Standard LazyVim starter layout:

```text
~/.config/nvim/
├── init.lua                  # leaders, optional profiler, bootstrap, :NvimUpdate stub
├── lua/
│   ├── config/
│   │   ├── lazy.lua          # lazy.nvim bootstrap, LazyVim + extras, plugin import
│   │   ├── options.lua       # only options that differ from LazyVim (+ machine overrides)
│   │   ├── keymaps.lua       # personal keymaps (loaded after LazyVim's)
│   │   ├── autocmds.lua      # only autocmds LazyVim does not already provide
│   │   ├── machine.lua       # per-host overrides from lua/config/machines/<host>.lua
│   │   ├── sql.lua           # shared SQLFluff dialect resolution
│   │   └── update.lua        # :NvimUpdate implementation (required on first use)
│   ├── plugins/              # personal plugins + overrides of LazyVim specs
│   │   └── disabled.lua      # LazyVim defaults intentionally turned off
│   └── snippets/
│       └── tex.lua           # LuaSnip LaTeX snippets
└── lazy-lock.json
```

LazyVim extras are imported explicitly in `lua/config/lazy.lua` (not through `:LazyExtras` / `lazyvim.json`) so every machine gets the same setup from git:
`coding.luasnip`, `editor.mini-diff`, `lang.json`, `lang.python`, `lang.sql`, `lang.tex`, `lang.toml`, `lang.yaml`.

Every file under `lua/plugins/` is discovered automatically. A spec with the same plugin name as a LazyVim spec is merged into it, so overrides only need the fields that change.

### What differs from stock LazyVim

- **Kept personal choices:** `minisummer` colorscheme, own lualine layout, stock Snacks dashboard, `persisted.nvim` sessions, `nvim-surround`, `smart-splits.nvim`, which-key `modern` preset, 4-space indentation, blink's default keymap preset with LuaSnip `<Tab>`/`<S-Tab>` jumping.
- **Disabled LazyVim defaults** (`lua/plugins/disabled.lua`): bufferline, persistence.nvim, tokyonight, catppuccin. gitsigns is replaced by mini.diff (extra).
- **LazyVim keymaps removed because they collided with personal ones:** `<leader>wd`/`<leader>wm` and the `<leader>w` window group (`<leader>w` saves), insert/select `<Esc>` snippet-unlinking, `<leader>n` (a group here), Noice `<leader>sn*` (`<leader>sn` is notification history), Snacks terminal `<C-h/j/k/l>` (smart-splits owns them), treesitter-textobjects `]f`/`]c`/`]a` moves (mini.bracketed owns them), visual `S` Flash (nvim-surround).
- LazyVim adds new keymaps that did not collide with anything, e.g. `<leader>l` (Lazy), `<S-h>`/`<S-l>` (prev/next buffer), `<A-j>`/`<A-k>` (move lines), `<leader>-`/`<leader>|` (splits), `<leader><tab>` (tabs), `<leader>ca`/`<leader>cr` (code action/rename), `<leader>uf` (toggle autoformat). See <https://www.lazyvim.org/keymaps>.

## Performance Design

- Custom plugin specs are lazy by default (`defaults.lazy = true`); each one declares its trigger (filetype, command, key, or event).
- mini.nvim is no longer loaded as one eager bundle: only the used modules (`mini.ai`, `mini.pairs`, `mini.icons`, `mini.diff`, `mini.operators`, `mini.move`, `mini.bracketed`, `mini.splitjoin`, `mini.hues`) are installed, each lazy-loaded.
- LazyVim defers clipboard setup, autocmds and keymaps until after the first screen draw, and lazy-loads Treesitter/LSP on file open.
- LuaSnip Lua snippets are loaded per filetype on demand (the 1,600-line LaTeX snippet file is only read for tex buffers).
- `:NvimUpdate` is a thin command stub; its implementation is only required when run.
- ALE was replaced by nvim-lint (proselint for Markdown/text, rubocop/ruby for Ruby), so there is a single linting engine.
- Dadbod completion is only active in SQL buffers instead of every filetype.
- `Snacks.bigfile` is the **single** large-file gate.
- VimTeX owns LaTeX syntax highlighting (Treesitter highlight is disabled for LaTeX).
- No duplicate Fidget/Noice LSP progress stack, cursorword/LSP reference highlighting, or icon provider.
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
