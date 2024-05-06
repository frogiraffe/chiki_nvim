vim.o.background = "dark"
vim.g.netrw_browse_split = 0
vim.api.nvim_command("autocmd FileType * setlocal formatoptions-=ro")
vim.g.netrw_banner = 0
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.conceallevel = 2
vim.opt.grepprg = "rg --vimgrep"
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepformat = "%f:%l:%c:%m"
vim.g.loaded_netrw = 1
vim.opt.autochdir = false
vim.g.loaded_netrwPlugin = 1
vim.g.hijack_netrw = true
vim.g.hijack_cursor = true
vim.g.hijack_unnamed_buffer_when_opening = true
vim.o.pumblend = 10
vim.opt.backup = false
vim.opt.expandtab = true
vim.opt.guicursor = ""
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.cmdheight = 0
vim.opt.isfname:append("@-@")
vim.opt.list = false
-- vim.cmd([[set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·]])
vim.opt.nu = true
vim.opt.relativenumber = true
-- vim.opt.number = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 200
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.mouse = "a"
vim.opt.updatetime = 50
vim.opt.lazyredraw = false
vim.opt.swapfile = false
vim.opt.updatetime = 200 -- Save swap file and trigger CursorHold
vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.opt.wildmode = "longest:full,full"
vim.opt.wrap = false
vim.opt.hidden = true
vim.opt.autowrite = true
vim.diagnostic.config({
	virtual_text = true,
	float = {
		border = "single",
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	signs = true,
})
-- vim.opt.smoothscroll = true

--diagnostic icons
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
vim.cmd([[
autocmd BufEnter * if &ft ==# 'help' | wincmd L | endif
]])
vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldenable = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.numberwidth = 3
vim.g.skip_ts_context_commentstring_module = true
