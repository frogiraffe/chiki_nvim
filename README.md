# chiki_nvim

A fast, lightweight, and modern Neovim configuration tailored for statistics, data science, academic research, SQL work, and software development.

## Requirements

* **Neovim:** `>= 0.11.4` (required by current `R.nvim` and modern LSP APIs)
* **Installation Path:** `~/.config/nvim`
* **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim) (automatically bootstrapped on first launch)

## Key External Dependencies

* **Core Tools:** `git`, `ripgrep`, `lazygit`
* **SQL / SQLite:** `sqlite3` (used by Dadbod for SQLite databases such as Chinook)
* **Font:** Any [Nerd Font](https://www.nerdfonts.com/) (e.g. JetBrains Mono Nerd Font)
* **Build Essentials:** GNU `make`, and a C compiler (`gcc` or `clang`) — required for building `R.nvim` (`nvimcom`), compiling Treesitter parsers, and `LuaSnip` regex support
* **R Ecosystem:** `R` (`>= 4.1.0`), GNU `make`, and a C compiler (`gcc` or `clang`)

## Supported Languages & Workflows

| Language / Area | LSP & Diagnostics | Formatting | Engine / Notes |
|---|---|---|---|
| **Lua** | `lua_ls` (via `vim.lsp.config`), `lazydev.nvim` | `stylua` | Neovim configuration & plugin development |
| **Python** | `basedpyright` | `conform.nvim` (`ruff_format`) | Data science & scripting; manages Ruff via Mason |
| **Rust** | `rustaceanvim` (`rust-analyzer`), `bacon-ls` (on-save `cargo check`) | `rustfmt` | Requires Rust toolchain (`rustc`, `cargo`, `rust-analyzer`) |
| **R & Statistics** | `R-nvim/R.nvim` (`rnvimserver`), `blink.cmp` | `styler` | Interactive R console, object browser, Quarto/Rmd support |
| **Web / JS / TS** | `ts_ls`, `eslint`, `html`, `cssls`, `jsonls`, `emmet_language_server` | Built-in / Conform | TypeScript/JavaScript, HTML, CSS, JSON, and Emmet support |
| **C / C++** | `clangd` | Built-in / LSP | Systems programming |
| **Go** | `gopls` | Built-in / LSP | Go development |
| **Shell & Config** | `bashls`, `yamlls`, `dockerls`, `docker_compose_language_service` | Built-in / LSP | Shell scripting, YAML, and Docker configurations |
| **SQL** | `sqls`, `vim-dadbod`, `vim-dadbod-completion` | Built-in | Database explorer, saved queries, execution, and schema-aware Blink completion |
| **LaTeX & Academic** | `vimtex` | Built-in / VimTeX | PDF forward/inverse search with `zathura` & `latexmk`, extensive `LuaSnip` math snippets |

## Database Workflow

Dadbod is integrated with the existing Blink completion stack:

```text
<leader>db    Toggle database UI
<leader>da    Add a database connection
<leader>df    Find the current database buffer
```

For a local SQLite database:

```text
sqlite:/absolute/path/to/database.sqlite
```

SQL buffers get table/column completion from the active Dadbod connection.

## Structure

```text
~/.config/nvim/
├── init.lua                  # Entry point & profiler hook
├── lua/
│   ├── config/
│   │   ├── lazy.lua          # lazy.nvim bootstrap; auto-imports config/plugins/*.lua
│   │   ├── options.lua       # Core Neovim options & environment setup
│   │   ├── keymaps.lua       # Global keybindings
│   │   ├── autocmds.lua      # File reload, last position, prose, transient buffers
│   │   └── plugins/          # Modular plugin specifications
│   └── snippets/
│       └── tex.lua           # LaTeX math & document snippets (LuaSnip)
└── lazy-lock.json            # Pinned plugin lockfile
```

Adding a new file under `lua/config/plugins/` is enough for lazy.nvim to discover it; `lazy.lua` no longer needs a matching manual import.

## Performance

* Core options are initialized before eager plugins.
* Treesitter is loaded on real file buffers instead of the empty dashboard startup path.
* Snacks handles big files and notifications; a second notification backend is not loaded.
* Unused built-in runtime plugins such as archive/tutorial handlers are disabled.
* Run `PROF=1 nvim` to use the existing Snacks startup profiler hook.
