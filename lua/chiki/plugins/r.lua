return {
	{
		"R-nvim/R.nvim",
		lazy = false,
		config = function()
			local opts = {
				RStudio_cmd = "/usr/lib/rstudio/rstudio",
			}
			require("r").setup(opts)
		end,
	},
}
