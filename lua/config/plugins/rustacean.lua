return {
	{
		"mrcjkb/rustaceanvim",
		version = "^9", -- Recommended for Neovim 0.12+
		lazy = false, -- This plugin is already lazy
		config = function()
			vim.g.rustaceanvim = {
				server = {
					settings = {
						["rust-analyzer"] = {
							checkOnSave = false, -- Disable RA cargo check, we use bacon
						},
					},
				},
			}
		end,
	},
}
