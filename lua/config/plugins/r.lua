return {
	{
		"R-nvim/R.nvim",
		lazy = false,
		opts = {
			R_args = { "--quiet", "--no-save" },
			hook = {
				on_filetype = function()
					vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", { desc = "R Send Line" })
					vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", { desc = "R Send Selection" })
				end,
			},
		},
	},
}
