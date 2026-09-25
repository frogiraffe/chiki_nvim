local color_filetypes = {
	"css",
	"html",
	"javascript",
	"javascriptreact",
	"lua",
	"typescript",
	"typescriptreact",
}

return {
	{
		"catgoose/nvim-colorizer.lua",
		ft = color_filetypes,
		opts = {
			filetypes = color_filetypes,
			user_default_options = {
				names = false,
				RGB = true,
				RRGGBB = true,
				AARRGGBB = true,
				mode = "background",
				max_lines = 10000,
			},
		},
		config = function(_, opts)
			require("colorizer").setup(opts)
		end,
	},
}
