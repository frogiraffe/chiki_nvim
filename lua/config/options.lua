-- Loaded by LazyVim *after* lazyvim.config.options and before any plugin, so
-- only settings that differ from LazyVim's defaults live here.
-- Defaults: https://www.lazyvim.org/configuration/general#options
local opt = vim.opt

vim.g.maplocalleader = ","
vim.g.have_nerd_font = true

-- LazyVim extras configuration.
vim.g.lazyvim_python_lsp = "basedpyright"

-- This config is Lua-native and none of the installed plugins use Neovim's
-- legacy Node/Perl/Python/Ruby remote-plugin hosts. Keep those providers off to
-- avoid unnecessary discovery work and misleading :checkhealth warnings.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Editing
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.autowrite = false
opt.whichwrap = "<,>,[,]"
opt.swapfile = false

-- Search and command-line behaviour
opt.inccommand = "split"

-- UI
opt.numberwidth = 2
opt.background = "dark"
opt.listchars = {
	tab = "   ",
	multispace = " ",
	trail = "",
	extends = "⟩",
	precedes = "⟨",
	nbsp = "␣",
}
opt.scrolloff = 10
opt.scrollback = 5000
opt.guicursor =
	"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Sessions: avoid restoring runtime paths and stale terminal processes while
-- preserving project buffers, tabs, folds and local window state.
opt.sessionoptions = {
	"buffers",
	"curdir",
	"tabpages",
	"winsize",
	"winpos",
	"help",
	"globals",
	"skiprtp",
	"folds",
	"localoptions",
}

-- Neovim GUI
opt.guifont = "JetBrainsMonoNerdFontMono:h12"

-- GUI launchers such as Rofi may not inherit ~/.cargo/bin. Prepend it once so
-- rust-analyzer/cargo resolve consistently without growing PATH every reload.
local cargo_bin = vim.fn.expand("~/.cargo/bin")
local path = vim.env.PATH or ""
if not vim.tbl_contains(vim.split(path, ":", { plain = true, trimempty = true }), cargo_bin) then
	vim.env.PATH = cargo_bin .. (path == "" and "" or ":" .. path)
end

vim.g.vimsyn_embed = "alpPrj"

if vim.g.neovide then
	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_cursor_vfx_mode = "sonicboom"
	vim.g.neovide_cursor_vfx_opacity = 200.0
	vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_window_blurred = true
	-- vim.g.neovide_transparency = 0.8
end

-- Per-machine overrides run last so they can adjust anything above.
require("config.machine")
