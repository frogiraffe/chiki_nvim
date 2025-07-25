return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VeryLazy",
		opts = {
			hide_numbers = true,
			autochdir = true,
			persistent_size = true,
			open_mapping = [[<C-Bslash>]],
		},
		keys = {
			{
				"<leader>tv",
				"<cmd>ToggleTerm direction=vertical size=80<CR>",
				desc = "Toggle vertical terminal",
				mode = { "n", "t" },
			},
			{
				"<leader>tf",
				"<cmd>ToggleTerm direction=float<CR>",
				desc = "Toggle floating terminal",
				mode = { "n", "t" },
			},
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)

			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end

			vim.api.nvim_create_autocmd("TermOpen", {
				pattern = "term://*",
				callback = function()
					set_terminal_keymaps()
				end,
			})
		end,
	},
}
