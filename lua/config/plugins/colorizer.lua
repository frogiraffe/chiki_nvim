return {
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			filetypes = { "css", "javascript", "html", "lua", "typescript", "typescriptreact", "javascriptreact" },
			user_default_options = {
				names = false, -- Disable color names like "Blue" to avoid false positives
				RGB = true,
				RRGGBB = true,
				AARRGGBB = true,
				mode = "background", -- "foreground", "background", "virtualtext"
				-- Large file protection
				max_lines = 10000,
			},
		},
		config = function(_, opts)
			require("colorizer").setup(opts)
		end,
	},
}
