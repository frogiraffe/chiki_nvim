-- Loaded by LazyVim on VeryLazy, after lazyvim.config.keymaps.
-- LazyVim defaults: https://www.lazyvim.org/keymaps
-- Plugin keymaps live in the plugin specs under lua/plugins/.
local map = vim.keymap.set

-- LazyVim defaults that would change existing behaviour:
-- * <leader>wd / <leader>wm turn <leader>w into a prefix and delay "Save Buffer".
-- * insert/select <Esc> would unlink the active LuaSnip snippet.
for _, m in ipairs({
	{ "n", "<leader>wd" },
	{ "n", "<leader>wm" },
	{ "i", "<esc>" },
	{ "s", "<esc>" },
}) do
	pcall(vim.keymap.del, m[1], m[2])
end

-- General
map({ "n", "v" }, "<leader>w", "<cmd>w<CR>", { desc = "Save Buffer" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to System Clipboard" })
map({ "i", "x", "n" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map("n", "<leader>bb", "<cmd>edit #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Search Highlight" })
map("", "<leader>cf", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })

-- Keep a visual selection after changing indentation.
map("x", "<", "<gv", { desc = "Indent Left" })
map("x", ">", ">gv", { desc = "Indent Right" })

-- LazyVim extends <C-s> (save) to select mode; keep Neovim's default there.
map("s", "<C-s>", vim.lsp.buf.signature_help, { desc = "vim.lsp.buf.signature_help()" })

-- Open a file path from terminal output in an existing editing split.
map("n", "gF", function()
	local line = vim.api.nvim_get_current_line()
	local file = line:match("(%S+%.%S+)")
	if not file then
		return
	end

	local buf = vim.fn.bufnr(file)
	if buf ~= -1 then
		vim.cmd("buffer " .. buf)
	else
		vim.cmd("edit " .. vim.fn.fnameescape(file))
	end
end, { desc = "Open file from terminal output line" })
