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
				plugins = {
					marks = true,
					registers = true,
					presets = {
						operators = true,
						motions = true,
						text_objects = true,
						windows = true,
						nav = true,
						z = true,
						g = true,
					},
					spelling = {
						enabled = true,
						suggestions = 20,
					},
				},
				icons = {
					breadcrumb = "»",
					separator = "➜",
					group = "+",
				},
				triggers = { "<leader>" },
				window = {
					border = "double",
					winblend = 20,
					align = "center",
				},
			})
			wk.register({
				["<leader><leader>"] = {
					name = "Swap Buffer",
				},
				["<leader>f"] = {
					name = "Telescope",
				},
				["<leader>t"] = {
					name = "Floating",
				},
				["<leader>x"] = {
					name = "Trouble",
				},
				["<leader>z"] = {
					name = "Zen",
				},
				["?"] = {
					name = "Old Files",
				},
				-- ["<leader>fy"] = {
				-- 	name = "Yank History",
				-- },
			})
		end,
	},
}
