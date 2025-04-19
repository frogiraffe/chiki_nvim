return {
	{
		"mrjones2014/smart-splits.nvim",
		keys = {
			{
				"<C-h>",
				function()
					require("smart-splits").move_cursor_left()
				end,
				mode = { "t", "n", "v" },
				desc = "which_key_ignore"
			},
			{
				"<C-j>",
				function()
					require("smart-splits").move_cursor_down()
				end,
				mode = { "t", "n", "v" },
				desc = "which_key_ignore"
			},
			{
				"<C-k>",
				function()
					require("smart-splits").move_cursor_up()
				end,
				mode = { "t", "n", "v" },
				desc = "which_key_ignore"
			},
			{
				"<C-l>",
				function()
					require("smart-splits").move_cursor_right()
				end,
				mode = { "t", "n", "v" },
				desc = "which_key_ignore"
			},
			{
				"<C-M-h>",
				function()
					require("smart-splits").resize_left()
				end,
				mode = { "t", "n", "v" },
				desc = "which_key_ignore"
			},
			{
				"<C-M-j>",
				function()
					require("smart-splits").resize_down()
				end,
				mode = { "t", "n", "v" },
				desc = "which_key_ignore"
			},
			{
				"<C-M-k>",
				function()
					require("smart-splits").resize_up()
				end,
				mode = { "t", "n", "v" },
				desc = "which_key_ignore"
			},
			{
				"<C-M-l>",
				function()
					require("smart-splits").resize_right()
				end,
				mode = { "t", "n", "v" },
				desc = "which_key_ignore"
			},
			{
				"<C-M-r>",
				function()
					require("smart-splits").start_resize_mode()
				end,
				{ desc = "resize mode" },
				mode = { "t", "n", "v" },
				desc = "which_key_ignore"
			},
			{
				"<leader><leader>h",
				function()
					require("smart-splits").swap_buf_left()
				end,
				mode = { "t", "n", "v" },
				desc = "which_key_ignore"
			},
			{
				"<leader><leader>j",
				function()
					require("smart-splits").swap_buf_down()
				end,
				mode = { "t", "n", "v" },
				desc = "which_key_ignore"
			},
			{
				"<leader><leader>l",
				function()
					require("smart-splits").swap_buf_right()
				end,
				mode = { "t", "n", "v" },
				desc = "which_key_ignore"
			},
			{
				"<leader><leader>k",
				function()
					require("smart-splits").swap_buf_up()
				end,
				mode = { "t", "n", "v" },
				desc = "which_key_ignore"
			},
		},
		config = function()
			require("smart-splits").setup({
				resize_mode = {
					quit_key = "<ESC>",
					hooks = {
						on_leave = require("bufresize").register,
					},
				},
			})
		end,
	},
	{
		"kwkarlwang/bufresize.nvim",
		event = "VeryLazy",
		config = function()
			require("bufresize").setup({
				resize = {
					keys = {},
					trigger_events = { "VimResized" },
				},
			})
		end,
	},
}
