return {
	{
		"R-nvim/R.nvim",
		lazy = false,
		config = function()
			local opts = {
				-- RStudio_cmd = "/usr/lib/rstudio/rstudio",
				hook = {
					on_filetype = function()
						-- This function will be called at the FileType event
						-- of files supported by R.nvim. This is an
						-- opportunity to create mappings local to buffers.
						vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
						vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
					end,
				},
				external_term = "tmux split-window -vf ",
				csv_app = "tmux new-window vd",
			}
			require("r").setup(opts)
		end,
	},
}
