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

			require("mini.operators").setup()
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
			require("mini.cursorword").setup()
			require("mini.diff").setup()
			require("mini.icons").setup()

			vim.cmd.colorscheme("minisummer")
		end,
	},
}
