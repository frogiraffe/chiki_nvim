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
				window = {
					border = "none",
					winblend = 20,
					align = "center",
				},
			})
			wk.register({
				-- ["<leader><leader>"] = {
				-- 	name = "Swap Buffer",
				-- },
				["<leader>f"] = {
					name = "Telescope",
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
				["<leader>fy"] = {
					name = "Yank History",
				},
				["<leader>k"] = {
					name = "Split code block ",
				},
				["<leader>b"] = {
					name = "BufferLine",
				},
				["<leader>c"] = {
					name = "Copilot",
				},
				["<leader>cc"] = {
					name = "Copilot",
				},
				["<leader>t"] = {
					name = "Floating Terminal",
				},
				["<leader>q"] = {
					name = "Session Management",
				},
				["<leader>g"] = {
					name = "Format Code",
				},
				-- ["<leader><leader>h"] = {
				-- 	name = "Buffer swap left"
				-- },
				-- ["<leader><leader>j"] = {
				-- 	name = "Buffer swap down"
				-- },
				-- ["<leader><leader>k"] = {
				-- 	name = "Buffer swap up"
				-- },
				-- ["<leader><leader>l"] = {
				-- 	name = "Buffer swap right"
				-- },
			})
		end,
	},
}
