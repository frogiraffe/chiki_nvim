return {
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_better_performance = true
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_transparent_background = 0
			vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
			vim.cmd("colorscheme gruvbox-material")
		end,
	},
	-- {
	--     "rebelot/kanagawa.nvim",
	--     lazy = false,
	--     priority = 1000,
	--     config = function()
	--         vim.cmd("colorscheme kanagawa-dragon")
	--     end,
	-- }
}
