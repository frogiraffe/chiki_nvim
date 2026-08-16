# chiki_nvim

A fast, lightweight, and modern Neovim configuration tailored for statistics, data science, academic research, and software development.

## Requirements

* **Neovim:** `>= 0.11.4` (required by current `R.nvim` and modern LSP APIs)
* **Installation Path:** `~/.config/nvim`
* **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim) (automatically bootstrapped on first launch)

## Key External Dependencies

* **Core Tools:** `git`, `ripgrep`, `lazygit`
* **Font:** Any [Nerd Font](https://www.nerdfonts.com/) (e.g. JetBrains Mono Nerd Font)
* **Build Essentials:** GNU `make`, and a C compiler (`gcc` or `clang`) — required for building `R.nvim` (`nvimcom`), compiling Treesitter parsers, and `LuaSnip` regex support
* **R Ecosystem (for R workflow):** `R` (`>= 4.1.0`), GNU `make`, and a C compiler (`gcc` or `clang`)

## Supported Languages & Workflows

| Language / Area | LSP & Diagnostics | Formatting | Engine / Notes |
|---|---|---|---|
| **Lua** | `lua_ls` (via `vim.lsp.config`), `lazydev.nvim` | `stylua` | Neovim configuration & plugin development |
| **Python** | `basedpyright` | `conform.nvim` (`ruff_format`) | Data science & scripting; manages Ruff via Mason |
| **Rust** | `rustaceanvim` (`rust-analyzer`), `bacon-ls` (on-save `cargo check`) | `rustfmt` | Requires Rust toolchain (`rustc`, `cargo`, `rust-analyzer`) |
| **R & Statistics** | `R-nvim/R.nvim` (`rnvimserver`), `blink.cmp` | `styler` | Interactive R console, object browser, Quarto/Rmd support; requires `R >= 4.1.0`, GNU `make`, `gcc`/`clang` |
| **Web / JS / TS** | `ts_ls`, `eslint`, `html`, `cssls`, `jsonls`, `emmet_language_server` | Built-in / Conform | Full TypeScript/JavaScript, HTML, CSS, JSON, and Emmet support |
| **C / C++** | `clangd` | Built-in / LSP | Systems programming |
| **Go** | `gopls` | Built-in / LSP | Go development |
| **Shell & Config** | `bashls`, `yamlls`, `dockerls`, `docker_compose_language_service` | Built-in / LSP | Shell scripting, YAML, and Docker configurations |
| **SQL** | `sqls` | Built-in / LSP | Database queries and schema management |
| **LaTeX & Academic** | `vimtex` | Built-in / VimTeX | PDF forward/inverse search with `zathura` & `latexmk`, extensive `LuaSnip` math snippets |

## Structure

```text
~/.config/nvim/
├── init.lua                  # Entry point & profiler hooks
├── lua/
│   ├── config/
│   │   ├── lazy.lua          # Lazy.nvim bootstrap & plugin imports
│   │   ├── options.lua       # Core Neovim options & settings
│   │   ├── keymaps.lua       # Global keybindings
│   │   ├── autocmds.lua      # Autocommands (yank highlight, spell on prose)
│   │   └── plugins/          # Modular plugin configurations
│   └── snippets/
│       └── tex.lua           # LaTeX math & document snippets (LuaSnip)
└── lazy-lock.json            # Pinned plugin lockfile
```
