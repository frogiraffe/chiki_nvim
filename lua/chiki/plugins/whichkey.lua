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
					group = ""
				},
				win = {
				},
				defaults = {
					mode = { "n", "v" },
				},
			})
			wk.add({
				{ "<leader>f", group = "[F]ind", icon = { icon = "🔭", color = "blue" } },
				{ "<leader>b", group = "[B]uffer", icon = { icon = "📂", color = "green" } },
				{ "<leader>c", group = "[C]opilot", icon = { icon = "🤖", color = "purple" } },
				{ "<leader>x", group = "[T]rouble", icon = { icon = "🚨", color = "red" } },
				{ "<leader>z", group = "[Z]en", icon = { icon = "🧘", color = "yellow" } },
				{ "?", group = "[O]ld Files", icon = { icon = "📜", color = "orange" } },
				{ "<leader>fy", group = "[Y]ank History", icon = { icon = "📋", color = "cyan" } },
				{ "<leader>g", group = "[F]ormat Code", icon = { icon = "🛠️", color = "magenta" } },
				{ "<leader>t", group = "[T]erminal", icon = { icon = "🖥️", color = "teal" } },
				{ "<leader>fg", group = "[G]it", icon = { icon = "🌱", color = "green" } },
			})
		end,
	},
}
