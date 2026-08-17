local opt = vim.opt
local o = vim.o

-- This config is Lua-native and none of the installed plugins use Neovim's
-- legacy Node/Perl/Python/Ruby remote-plugin hosts. Keep those providers off to
-- avoid unnecessary discovery work and misleading :checkhealth warnings.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Persistent undo
local undo_dir = vim.fn.stdpath("cache") .. "/undo/"
vim.fn.mkdir(undo_dir, "p")
opt.undodir = undo_dir
opt.undofile = true
opt.undolevels = 10000

-- Editing
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.shiftround = true
opt.smartindent = true
opt.smarttab = true
opt.completeopt = "menu,menuone,noselect"
opt.virtualedit = "block"
opt.whichwrap = "<,>,[,]"
opt.swapfile = false
opt.confirm = true

-- Search and command-line behaviour
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"
opt.wildmode = "longest:full,full"
opt.jumpoptions = "view"

-- UI
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.laststatus = 3
opt.showmode = false
opt.ruler = false
opt.pumheight = 10
opt.pumblend = 10
opt.conceallevel = 2
opt.list = true
opt.listchars = {
	tab = "   ",
	multispace = " ",
	trail = "",
	extends = "⟩",
	precedes = "⟨",
	nbsp = "␣",
}
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

-- Windows and scrolling
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.scrolloff = 10
opt.sidescrolloff = 8
opt.smoothscroll = true
opt.scrollback = 5000
opt.winminwidth = 5
opt.wrap = false
opt.linebreak = true

-- Folding. Treesitter switches foldmethod/foldexpr for supported buffers.
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Input / responsiveness
opt.mouse = "a"
o.updatetime = 200
o.timeoutlen = 300
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

-- Let Neovim use OSC52 automatically over SSH; use the system clipboard on
-- the local desktop. Scheduling avoids doing provider work on the hot startup path.
vim.schedule(function()
	o.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"
end)

-- GUI launchers such as Rofi may not inherit ~/.cargo/bin. Prepend it once so
-- rust-analyzer/cargo resolve consistently without growing PATH every reload.
local cargo_bin = vim.fn.expand("~/.cargo/bin")
local path = vim.env.PATH or ""
local path_entries = vim.split(path, ":", { plain = true, trimempty = true })
if not vim.tbl_contains(path_entries, cargo_bin) then
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
	vim.g.neovide_transparency = 0.8
end
