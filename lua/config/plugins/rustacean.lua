return {
	{
		"mrcjkb/rustaceanvim",
		version = "^9", -- Recommended for Neovim 0.12+
		lazy = false, -- This plugin is already lazy
		init = function()
			vim.g.rustaceanvim = {
				server = {
					cmd = function()
						local exepath = vim.fn.exepath("rust-analyzer")
						if exepath ~= "" then
							return { exepath }
						end
						-- Eğer PATH içinde bulunamazsa, rustup aracılığıyla çalıştır
						return { "rustup", "run", "stable", "rust-analyzer" }
					end,
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
