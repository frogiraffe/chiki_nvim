local map = vim.keymap.set

-- General
map({ "n", "v" }, "<leader>w", "<cmd>w<CR>", { desc = "Save Buffer" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to System Clipboard" })
map({ "i", "x", "n" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map("n", "<leader>bb", "<cmd>edit #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Search Highlight" })

-- When a prose line is visually wrapped, j/k follow what is on screen. Counts
-- still use real lines, so 5j keeps standard Vim semantics.
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Down" })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Up" })

-- Keep a visual selection after changing indentation.
map("x", "<", "<gv", { desc = "Indent Left" })
map("x", ">", ">gv", { desc = "Indent Right" })

-- Create useful undo boundaries while typing prose, code and SQL.
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", ";", ";<C-g>u")

-- Terminal mode split navigation (Snacks.terminal).
map("t", "<C-h>", function()
	require("smart-splits").move_cursor_left()
end, { desc = "Move to left split" })
map("t", "<C-j>", function()
	require("smart-splits").move_cursor_down()
end, { desc = "Move to down split" })
map("t", "<C-k>", function()
	require("smart-splits").move_cursor_up()
end, { desc = "Move to up split" })
map("t", "<C-l>", function()
	require("smart-splits").move_cursor_right()
end, { desc = "Move to right split" })

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
