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
			-- Structured format (replaces the legacy flat `user_default_options`).
			-- `max_lines` no longer exists in the plugin, so it is dropped.
			options = {
				parsers = {
					names = { enable = false },
					hex = {
						rgb = true,
						rrggbb = true,
						aarrggbb = true,
					},
				},
				display = { mode = "background" },
			},
			filetypes = color_filetypes,
		},
		config = function(_, opts)
			require("colorizer").setup(opts)
		end,
	},
}
