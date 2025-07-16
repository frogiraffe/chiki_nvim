-- which-key and keymap config

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Normal mode
keymap("n", "<C-q>", function() vim.cmd.bdelete() end, opts)
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<leader>q", "<cmd>bd<CR>", { desc = "Close buffer" })
keymap("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", "U", "<C-r>")
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Visual mode
keymap("v", ">", ">gv")
keymap("v", "<", "<gv")
keymap("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })

-- Visual block mode
keymap("x", "<leader>p", [["_dP]], { desc = "Paste and replace" })

-- Insert mode
keymap("i", "<C-c>", "<Esc>")

-- Command mode
keymap("c", "<tab>", "<C-z>", { noremap = true, silent = false })

-- Disable macOS Command+Space (for all modes)
keymap({ "n", "v", "t" }, "<D-Space>", "<Nop>", { noremap = true, silent = true })
keymap({ "i", "t" }, "<D-Space>", "<Nop>", { noremap = true, silent = true })

-- LSP-related keymaps (set on LspAttach)
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function()
		keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
		keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Go to declaration" })
		keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Go to implementation" })
		keymap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Go to type definition" })
		keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Go to references" })
		keymap("n", "[s", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Show signature help" })
		keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Previous diagnostic" })
		keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Next diagnostic" })
		keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show diagnostic float" })
		keymap("n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename symbol" })
	end,
})

-- Compiler plugin keymaps
keymap("n", "<F6>", "<cmd>CompilerOpen<cr>", { noremap = true, silent = true, desc = "Open compiler" })
keymap("n", "<F7>", "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true, desc = "Toggle compiler results" })

-- Neovide clipboard support
if vim.g.neovide then
	vim.api.nvim_set_keymap('v', '<sc-c>', '"+y', { noremap = true })
	vim.api.nvim_set_keymap('n', '<sc-v>', 'l"+P', { noremap = true })
	vim.api.nvim_set_keymap('v', '<sc-v>', '"+P', { noremap = true })
	vim.api.nvim_set_keymap('c', '<sc-v>', '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
	vim.api.nvim_set_keymap('i', '<sc-v>', '<ESC>l"+Pli', { noremap = true })
	vim.api.nvim_set_keymap('t', '<sc-v>', '<C-\\><C-n>"+Pi', { noremap = true })
end

-- which-key config
return {
	{
		"folke/which-key.nvim",
		init = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 300
		end,
		opts = {
			plugins = {
				marks = true,
				registers = true,
				spelling = {
					enabled = true,
					suggestions = 20,
				},
				presets = {
					operators = true,
					motions = true,
					text_objects = true,
					windows = true,
					nav = true,
					z = true,
					g = true,
				},
			},
			icons = {
				breadcrumb = "»",
				separator = "➜",
				group = "",
			},
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader>p", '"+p',         desc = "Paste from clipboard" },
					{ "<leader>q", "<cmd>bd<CR>", desc = "Close buffer" },
					{ "<leader>w", "<cmd>w<CR>",  desc = "Save file" },
					{ "<leader>y", '"+y',         desc = "Yank to clipboard",   mode = "v" },
				},
			},
		},
	},
}
