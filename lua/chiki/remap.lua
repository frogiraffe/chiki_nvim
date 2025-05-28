local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
keymap("v", ">", ">gv")
keymap("v", "<", "<gv")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("x", "<leader>p", [["_dP]], { desc = "paste and replace" })
-- keymap({ "v" }, "<leader>d", [["_d]], { desc = "delete to void" })
keymap("i", "<C-c>", "<Esc>")
keymap("n", "U", "<C-r>")
keymap("v", "<leader>y", '"+y')
keymap("n", "<C-q>", "<cmd>BufferClose<CR>")
keymap("n", "<leader>q", "<cmd>bd<CR>", { desc = "which_key_ignore" })
keymap("n", "<leader>p", '"+p', { desc = "which_key_ignore" })
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "which_key_ignore" })
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap({ "n", "v", "t" }, "<D-Space>", "<Nop>", { noremap = true, silent = true })
keymap("c", "<tab>", "<C-z>", { noremap = true, silent = false })
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "lsp actions",
	callback = function(event)
		-- keymap("n", "K", "<cmd>:lua vim.lsp.buf.hover()<CR>", { desc = "hover doc" })
		keymap("n", "gd", "<cmd>:lua vim.lsp.buf.definition()<CR>", { desc = "go to definition" })
		keymap("n", "gD", "<cmd>:lua vim.lsp.buf.declaration()<CR>", { desc = "go to declaration" })
		keymap("n", "gi", "<cmd>:lua vim.lsp.buf.implementation()<CR>", { desc = "go to implementation" })
		keymap("n", "go", "<cmd>:lua vim.lsp.buf.type_definition()<CR>", { desc = "go to type definition" })
		keymap("n", "gr", "<cmd>:lua vim.lsp.buf.references()<CR>", { desc = " go to references" })
		keymap("n", "[s", "<cmd>:lua vim.lsp.buf.signature_help()<CR>", { desc = "show signature help" })
		keymap("n", "[d", "<cmd>:lua vim.diagnostic.goto_prev()<CR>", { desc = "go to previous diagnostic" })
		keymap("n", "]d", "<cmd>:lua vim.diagnostic.goto_next()<CR>", { desc = "go to next diagnostic" })
		keymap("n", "gl", "<cmd>:lua vim.diagnostic.open_float()<CR>", { desc = "open diagnostic float" })
		keymap("n", "gR", "<cmd>:lua vim.lsp.buf.rename()<CR>", { desc = "rename" })
		-- keymap("n", "ca", "<cmd>:lua vim.lsp.buf.code_action()<CR>", { desc = "code action" })
	end,
})
vim.keymap.set({ "i", "t" }, "<D-Space>", "<Nop>", { noremap = true, silent = true })
-- Open compiler
vim.api.nvim_set_keymap("n", "<F6>", "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })

-- -- Redo last selected option
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<S-F6>",
-- 	"<cmd>CompilerStop<cr>" -- (Optional, to dispose all tasks before redo)
-- 		.. "<cmd>CompilerRedo<cr>",
-- 	{ noremap = true, silent = true }
-- )

-- Toggle compiler results
vim.api.nvim_set_keymap("n", "<F7>", "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })
keymap('n', '<S-h>', '<Cmd>BufferPrevious<CR>', opts)
keymap('n', '<S-l>', '<Cmd>BufferNext<CR>', opts)
keymap('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
keymap('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Pin/unpin buffer
keymap('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
keymap('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
keymap('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
keymap('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', opts)
keymap('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
keymap('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
keymap('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
if vim.g.neovide then
	vim.api.nvim_set_keymap('v', '<sc-c>', '"+y', { noremap = true })
	vim.api.nvim_set_keymap('n', '<sc-v>', 'l"+P', { noremap = true })
	vim.api.nvim_set_keymap('v', '<sc-v>', '"+P', { noremap = true })
	vim.api.nvim_set_keymap('c', '<sc-v>', '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
	vim.api.nvim_set_keymap('i', '<sc-v>', '<ESC>l"+Pli', { noremap = true })
	vim.api.nvim_set_keymap('t', '<sc-v>', '<C-\\><C-n>"+Pi', { noremap = true })
end
