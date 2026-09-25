-- LazyVim already provides mini.ai, mini.pairs, mini.icons and (via the
-- editor.mini-diff extra) mini.diff as standalone, lazy-loaded modules. The
-- remaining modules are split out the same way instead of loading the whole
-- mini.nvim bundle eagerly at startup.
return {
	-- Colorscheme (minisummer ships with mini.hues). Loaded by LazyVim at startup.
	{ "nvim-mini/mini.hues", lazy = false, priority = 1000 },

	{
		"nvim-mini/mini.operators",
		event = "VeryLazy",
		opts = {
			-- Keep Neovim 0.11+'s `gr*` LSP namespace intact. A leader mapping
			-- avoids delaying core operators such as `c`.
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
	{
		"nvim-mini/mini.bracketed",
		-- Load after LazyVim's default keymaps so mini's [b ]b [q ]q [w ]w ...
		-- keep precedence over LazyVim's overlapping bracket mappings.
		event = "User LazyVimKeymaps",
		opts = {},
	},
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

	-- mini.diff replaces gitsigns (editor.mini-diff extra). Keep its default
	-- sign characters instead of the extra's bar style.
	{
		"nvim-mini/mini.diff",
		opts = function(_, opts)
			opts.view = nil
		end,
	},
}
