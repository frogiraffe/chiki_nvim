-- Each mini module is its own lazily loaded plugin (as in LazyVim) instead of
-- the whole mini.nvim bundle being set up eagerly at startup.
return {
	-- Colorscheme (minisummer ships with mini.hues).
	{
		"nvim-mini/mini.hues",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("minisummer")
		end,
	},

	-- Icons are loaded on first use. Plugins that still `require("nvim-web-devicons")`
	-- get mini.icons' compatible API without a second icon provider.
	{
		"nvim-mini/mini.icons",
		opts = {},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	{
		"nvim-mini/mini.ai",
		event = "VeryLazy",
		-- Supplies the @function/@class/@block queries used by af/ac/ao below.
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		opts = function()
			local ai = require("mini.ai")
			return {
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
			}
		end,
	},

	-- Keep Neovim 0.11+'s `gr*` LSP namespace and native editing prefixes
	-- intact. A leader mapping avoids delaying core operators such as `c`.
	{
		"nvim-mini/mini.operators",
		event = "VeryLazy",
		opts = {
			replace = { prefix = "<leader>r" },
		},
	},

	{
		"nvim-mini/mini.move",
		event = "VeryLazy",
		opts = {
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
		},
	},

	-- mini.pairs is enough for this config's bracket/quote workflow. Command-line
	-- pairing keeps the useful cmap behavior from the previous autopair plugin.
	{
		"nvim-mini/mini.pairs",
		event = "VeryLazy",
		opts = {
			modes = { insert = true, command = true, terminal = false },
		},
	},

	{ "nvim-mini/mini.bracketed", event = "VeryLazy", opts = {} },
	{ "nvim-mini/mini.diff", event = "VeryLazy", opts = {} },

	-- mini.splitjoin replaces treesj and keeps the old keymaps.
	{
		"nvim-mini/mini.splitjoin",
		keys = {
			{ "<leader>jm", mode = { "n", "x" }, desc = "Toggle arguments" },
			{ "<leader>jj", mode = { "n", "x" }, desc = "Join arguments" },
			{ "<leader>js", mode = { "n", "x" }, desc = "Split arguments" },
		},
		opts = {
			mappings = {
				toggle = "<leader>jm",
				join = "<leader>jj",
				split = "<leader>js",
			},
		},
	},

	-- Snacks.words owns cursor/LSP reference highlighting, so mini.cursorword
	-- stays disabled to avoid duplicating that work.
}
