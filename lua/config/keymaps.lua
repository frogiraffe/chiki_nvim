-- General Keymaps
vim.keymap.set({ "n", "v" }, "<leader>w", "<cmd>:w<CR>", { desc = "Save Buffer" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to System Clipboard" })

-- gf split'te ac (terminal kapanmasin)
vim.keymap.set("n", "gf", "<cmd>split<CR>gf", { desc = "Open file in split" })

-- Terminal modunda split navigasyonu (Snacks.terminal icin)
vim.keymap.set("t", "<C-h>", function()
	require("smart-splits").move_cursor_left()
end, { desc = "Move to left split" })
vim.keymap.set("t", "<C-j>", function()
	require("smart-splits").move_cursor_down()
end, { desc = "Move to down split" })
vim.keymap.set("t", "<C-k>", function()
	require("smart-splits").move_cursor_up()
end, { desc = "Move to up split" })
vim.keymap.set("t", "<C-l>", function()
	require("smart-splits").move_cursor_right()
end, { desc = "Move to right split" })

-- Terminal ciktilarindan dosya ac - mevcut split'te
vim.keymap.set("n", "gF", function()
	local line = vim.api.nvim_get_current_line()
	local file = line:match("(%S+%.%S+)") -- dosya yolunu yakala
	if file then
		-- Eger dosya zaten aciksa ona gec, yoksa mevcut split'te ac
		local buf = vim.fn.bufnr(file)
		if buf ~= -1 then
			vim.cmd("buffer " .. buf)
		else
			vim.cmd("edit " .. vim.fn.fnameescape(file))
		end
	end
end, { desc = "Open file from terminal output line" })
