return {
	{
		"stevearc/aerial.nvim",
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("aerial").setup({
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Aerial Prev" })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Aerial Next" })
				end,
			})
			-- You probably also want to set a keymap to toggle aerial
			vim.keymap.set("n", "<leader>oa", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial (Outline)" })
			vim.keymap.set(
				"n",
				"<leader>os",
				"<cmd>require('aerial').snacks_picker()<CR>",
				{ desc = "Search Symbols (Aerial)" }
			)
		end,
	},
}
