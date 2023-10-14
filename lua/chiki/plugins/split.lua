return {
	{
		"mrjones2014/smart-splits.nvim",
		keys = {
			{
				"<C-h>",
				function()
					require("smart-splits").move_cursor_left()
				end,
			},
			{
				"<C-j>",
				function()
					require("smart-splits").move_cursor_down()
				end,
			},
			{
				"<C-k>",
				function()
					require("smart-splits").move_cursor_up()
				end,
			},
			{
				"<C-l>",
				function()
					require("smart-splits").move_cursor_right()
				end,
			},
			{
				"<C-M-h>",
				function()
					require("smart-splits").resize_left()
				end,
			},
			{
				"<C-M-j>",
				function()
					require("smart-splits").resize_down()
				end,
			},
			{
				"<C-M-k>",
				function()
					require("smart-splits").resize_up()
				end,
			},
			{
				"<C-M-l>",
				function()
					require("smart-splits").resize_right()
				end,
			},
			{
				"<C-r>",
				function()
					require("smart-splits").start_resize_mode()
				end,
				{ desc = "resize mode" },
			},
			{
				"<leader><leader>h",
				function()
					require("smart-splits").swap_buf_left()
				end,
				{ desc = "swap buffer w left" },
			},
			{
				"<leader><leader>j",
				function()
					require("smart-splits").swap_buf_down()
				end,
				{ desc = "swap buffer w down" },
			},
			{
				"<leader><leader>l",
				function()
					require("smart-splits").swap_buf_right()
				end,
				{ desc = "swap buffer w up" },
			},
			{
				"<leader><leader>k",
				function()
					require("smart-splits").swap_buf_up()
				end,
				{ desc = "swap buffer w up" },
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
