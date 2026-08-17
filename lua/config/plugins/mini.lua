return {
	{
		"nvim-mini/mini.nvim",
		lazy = false,
		priority = 1000,
		version = false,
		config = function()
			local ai = require("mini.ai")
			ai.setup({
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
					d = { "%f[%d]%d+" },
					u = ai.gen_spec.function_call(),
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),
				},
			})

			-- Keep Neovim 0.11+'s `gr*` LSP namespace intact. mini.operators uses
			-- `gr` for replace by default, so move only that operator to `gR`.
			require("mini.operators").setup({
				replace = { prefix = "gR" },
			})

			require("mini.move").setup({
				mappings = {
					left = "<A-S-h>",
					right = "<A-S-l>",
					down = "<A-S-j>",
					up = "<A-S-k>",
					line_left = "<A-S-h>",
					line_right = "<A-S-l>",
					line_down = "<A-S-j>",
					line_up = "<A-S-k>",
				},
			})

			require("mini.bracketed").setup()
			require("mini.diff").setup()

			-- treesj was only used for split/join. mini.splitjoin covers the same
			-- everyday workflow without another plugin and keeps the old keymaps.
			require("mini.splitjoin").setup({
				mappings = {
					toggle = "<leader>jm",
					join = "<leader>jj",
					split = "<leader>js",
				},
			})

			local icons = require("mini.icons")
			icons.setup()
			-- Supply the devicons API to plugins that still expect it without
			-- carrying nvim-web-devicons as a second icon provider.
			icons.mock_nvim_web_devicons()

			-- Snacks.words owns cursor/LSP reference highlighting. Keeping
			-- mini.cursorword enabled here would duplicate that work.
			vim.cmd.colorscheme("minisummer")
		end,
	},
}
