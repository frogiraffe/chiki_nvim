-- Settings for Neovim

-- General options
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.conceallevel = 2
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.formatoptions = "jcroqlnt"
vim.opt.autochdir = false
vim.opt.backup = false
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.cmdheight = 0
vim.opt.isfname:append("@-@")
vim.opt.list = false
vim.opt.nu = true
vim.opt.number = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.mouse = "a"
vim.opt.updatetime = 200 -- Save swap file and trigger CursorHold
vim.opt.lazyredraw = false
vim.opt.swapfile = false
vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.opt.showmode = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wrap = false
vim.opt.hidden = true
vim.opt.autowrite = true
vim.opt.numberwidth = 3

-- Folds
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldenable = true

-- Splits
vim.o.splitbelow = true
vim.o.splitright = true

-- Netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Misc
vim.g.hijack_unnamed_buffer_when_opening = true
vim.g.skip_ts_context_commentstring_module = true

-- Popup menu
vim.o.pumblend = 10

-- Diagnostic config
vim.diagnostic.config({
	virtual_text = false,
	float = {
		border = "single",
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	signs = true,
})

-- Diagnostic icons
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "Error",
			[vim.diagnostic.severity.WARN] = "Warn",
			[vim.diagnostic.severity.INFO] = "Info",
			[vim.diagnostic.severity.HINT] = "Hint",
		},
	},
})

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- Highlight Copilot completion
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

-- Autocommands
vim.api.nvim_command("autocmd FileType * setlocal formatoptions-=ro")
vim.cmd([[
autocmd BufEnter * if &ft ==# 'help' | wincmd L | endif
]])

-- Local options for Lua files
vim.opt_local.include = [[\v<((do|load)file|require)[^''"]*[''"]\zs[^''"]+]]
vim.opt_local.includeexpr = "substitute(v:fname,'\\.','/','g')"
for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
	vim.opt_local.path:append(path .. '/lua')
end
vim.opt_local.suffixesadd:prepend('.lua')

-- Commented/legacy options
-- vim.o.background = "dark"
-- vim.g.netrw_browse_split = 0
-- vim.cmd([[set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·]])
-- vim.opt.timeoutlen = 50
-- vim.opt.smoothscroll = true
-- vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB
