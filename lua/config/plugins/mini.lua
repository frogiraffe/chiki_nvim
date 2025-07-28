return {
	{
		"echasnovski/mini.nvim",
		lazy = true,
		version = false,
		config = function()
			require("mini.operators").setup()
			require("mini.move").setup({
				mappings = {
					-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
					left = "<A-h>",
					right = "<A-l>",
					down = "<A-j>",
					up = "<A-k>",

					-- Move current line in Normal mode
					line_left = "<A-h>",
					line_right = "<A-l>",
					line_down = "<A-j>",
					line_up = "<A-k>",
				},
			})
			-- require("mini.ai").setup()
			require("mini.bracketed").setup()
			require("mini.cursorword").setup()
			require("mini.icons").setup()
			-- require("mini.trailspace").setup({
			-- 	only_in_normal_buffers = true,
			-- })
		end,
	},
}
