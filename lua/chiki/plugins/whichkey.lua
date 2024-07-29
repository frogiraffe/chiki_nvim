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
				-- triggers = { "<leader>" },
				win = {
				},
				defaults = {
					mode = { "n", "v" },
				},
			})
			wk.add({
				{
					"<leader><leader>",
					desc = "Swap Buffer",
				},
				{
					"<leader>f",
					desc = "Telescope",
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
					"<leader>k",
					desc = "Split code block",
				},
				{
					"<leader>b",
					desc = "Buffer",
				},
				{
					"<leader>c",
					desc = "Copilot",
				},
				{
					"<leader>cc",
					desc = "Copilot",
				},
				{
					"<leader>t",
					desc = "Floating Terminal",
				},
				{
					"<leader>q",
					desc = "Session Management",
				},
				{
					"<leader>g",
					desc = "Format Code",
				},
				{
					"<leader>fg",
					desc = "Git",
				},
				-- ["<leader>xd"] = {
				-- 	name = "Document Diagnostics",
				-- },
				-- ["<leader>xt"] = {
				-- 	name = "Troble Todo",
				-- },
				-- ["<leader>xT"] = {
				-- 	name = "Troble Todo/Fixme/Notes",
				-- },
				-- ["<leader>xw"] = {
				-- 	name = "Troble Workspace Diagnostics",
				-- },
			})
		end,
	},
}
