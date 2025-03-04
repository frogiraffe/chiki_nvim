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
				preset = "helix",
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
				win = {
				},
				defaults = {
					mode = { "n", "v" },
				},
			})
			wk.add({
				-- {
				-- 	"<leader><leader>",
				-- 	desc = "Swap Buffer",
				-- },
				{
					"<leader>f",
					desc = "Telescope",
				},
				{
					"<leader>b",
					desc = "Buffer"
				},
				{
					"<leader>c",
					desc = "Copilot"
				},
				{
					"<leader>x",
					desc = "Trouble",
				},
				{
					"<leader>z",
					desc = "Zen",
				},
				{
					"?",
					desc = "Old Files",
				},
				{
					"<leader>fy",
					desc = "Yank History",
				},
				{
					"<leader>g",
					desc = "Format Code",
				},
				{
					"<leader>t",
					desc = "Floating Terminal",
				},
				{
					"<leader>fg",
					desc = "Git",
				},
			})
		end,
	},
}
