-- General Keymaps
vim.keymap.set({ "n", "v" }, "<leader>w", "<cmd>:w<CR>", { desc = "Save Buffer" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to System Clipboard" })
