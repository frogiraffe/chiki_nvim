return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.operators").setup()
			require("mini.move").setup()
			require("mini.ai").setup()
			require("mini.bracketed").setup()
			require("mini.cursorword").setup()
			require("mini.icons").setup()
			-- require("mini.trailspace").setup({
			-- 	only_in_normal_buffers = true,
			-- })
		end,
	},
}
