return {
	{
		"mrcjkb/rustaceanvim",
		version = "^9",
		ft = { "rust" },
		init = function()
			vim.g.rustaceanvim = {
				server = {
					cmd = function()
						local exepath = vim.fn.exepath("rust-analyzer")
						if exepath ~= "" then
							return { exepath }
						end
						return { "rustup", "run", "stable", "rust-analyzer" }
					end,
					default_settings = {
						["rust-analyzer"] = {
							checkOnSave = false, -- bacon-ls owns cargo diagnostics
							files = {
								exclude = {
									".direnv",
									".git",
									".github",
									"node_modules",
									"target",
									"venv",
									".venv",
								},
								watcher = "client",
							},
						},
					},
				},
			}
		end,
	},
}
