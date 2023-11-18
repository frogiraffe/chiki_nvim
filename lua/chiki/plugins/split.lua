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
			},
			{
				"<C-j>",
				function()
					require("smart-splits").move_cursor_down()
				end,
				mode = { "t", "n", "v" },
			},
			{
				"<C-k>",
				function()
					require("smart-splits").move_cursor_up()
				end,
				mode = { "t", "n", "v" },
			},
			{
				"<C-l>",
				function()
					require("smart-splits").move_cursor_right()
				end,
				mode = { "t", "n", "v" },
			},
			{
				"<C-M-h>",
				function()
					require("smart-splits").resize_left()
				end,
				mode = { "t", "n", "v" },
			},
			{
				"<C-M-j>",
				function()
					require("smart-splits").resize_down()
				end,
				mode = { "t", "n", "v" },
			},
			{
				"<C-M-k>",
				function()
					require("smart-splits").resize_up()
				end,
				mode = { "t", "n", "v" },
			},
			{
				"<C-M-l>",
				function()
					require("smart-splits").resize_right()
				end,
				mode = { "t", "n", "v" },
			},
			{
				"<C-r>",
				function()
					require("smart-splits").start_resize_mode()
				end,
				{ desc = "resize mode" },
				mode = { "t", "n", "v" },
			},
			{
				"<leader><leader>h",
				function()
					require("smart-splits").swap_buf_left()
				end,
				{ desc = "swap buffer w left" },
				mode = { "t", "n", "v" },
			},
			{
				"<leader><leader>j",
				function()
					require("smart-splits").swap_buf_down()
				end,
				{ desc = "swap buffer w down" },
				mode = { "t", "n", "v" },
			},
			{
				"<leader><leader>l",
				function()
					require("smart-splits").swap_buf_right()
				end,
				{ desc = "swap buffer w up" },
				mode = { "t", "n", "v" },
			},
			{
				"<leader><leader>k",
				function()
					require("smart-splits").swap_buf_up()
				end,
				{ desc = "swap buffer w up" },
				mode = { "t", "n", "v" },
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
