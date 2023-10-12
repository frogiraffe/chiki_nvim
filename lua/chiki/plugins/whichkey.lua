return {
	{
		"folke/which-key.nvim",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
		config = function()
			local wk = require("which-key")
			wk.setup({
				triggers = { "<leader>" },
			})
			wk.register({
				["<leader><leader>"] = {
					name = "swap buffer",
				},
				["<leader>b"] = {
					name = "navbuddy",
				},
				["<leader>f"] = {
					name = "telescope",
				},
				["<leader>t"] = {
					name = "floating",
				},
				["<leader>x"] = {
					name = "trouble",
				},
				["<leader>z"] = {
					name = "zen",
				},
			})
		end,
	},
}
