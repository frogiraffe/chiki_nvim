local undo_dir = vim.fn.stdpath("cache") .. "/undo/"
vim.fn.mkdir(undo_dir, "p")
vim.opt.undodir = undo_dir
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.splitkeep = "screen"
-- vim.opt.fillchars:append(',eob: ')
vim.opt.scrolloff = 10
vim.opt.scrollback = 5000
vim.opt.mouse = "a"
vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.opt.whichwrap = "<,>,[,]"
vim.opt.encoding = "UTF-8"
vim.log.level = "warn"
vim.opt.number = true
vim.opt.syntax = "enable"
vim.opt.termguicolors = true
vim.opt.tabstop = 4
-- vim.opt.showmode      = false
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.numberwidth = 2
vim.opt.wrap = true
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
vim.opt.background = "dark"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hidden = true
vim.opt.foldlevel = 99
vim.opt.list = true
vim.opt.spell = true
vim.opt.listchars = {
	-- Replace tab whitespace with -->
	tab = "   ",
	multispace = " ",
	trail = "",
	extends = "⟩",
	precedes = "⟨",
	nbsp = "␣",
}
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.g.vimsyn_embed = "alpPrj"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.g.have_nerd_font = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.inccommand = "split"
-- vim.o.confirm = true
