vim.o.background = "dark"
vim.loader.enable()
vim.g.netrw_browse_split = 0
vim.api.nvim_command("autocmd FileType * setlocal formatoptions-=ro")
vim.g.netrw_banner = 0
vim.g.loaded_netrw = 1
vim.opt.autochdir = true
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
vim.opt.cmdheight = 1
vim.opt.isfname:append("@-@")
vim.opt.list = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 200
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.mouse = 'a'
vim.opt.updatetime = 50
vim.opt.lazyredraw = false
vim.opt.wrap = false
vim.opt.hidden = true
vim.diagnostic.config({
    virtual_text = true,
    float = {
        border = "rounded",
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    signs = true,

})

--diagnostic icons
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
vim.cmd([[
autocmd BufEnter * if &ft ==# 'help' | wincmd L | endif
]])
vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.numberwidth = 3
-- vim.g.vimtex_compiler_method = 'latexrun'
-- vim.g.vimtex_view_method = 'zathura'
