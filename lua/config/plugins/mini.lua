return {
	{
		"echasnovski/mini.nvim",
		lazy = false,
		version = false,
		config = function()
			require("mini.operators").setup()
			require("mini.move").setup({
				mappings = {
					-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
					left = "<A-S-h>",
					right = "<A-S-l>",
					down = "<A-S-j>",
					up = "<A-S-k>",
					-- Move current line in Normal mode
					line_left = "<A-S-h>",
					line_right = "<A-S-l>",
					line_down = "<A-S-j>",
					line_up = "<A-S-k>",
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
