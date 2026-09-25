return {
	{
		"linux-cultist/venv-selector.nvim",
		cmd = "VenvSelect",
		ft = "python",
		keys = {
			{ "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select Python VirtualEnv", ft = "python" },
		},
		opts = {
			options = {
				notify_user_on_venv_activation = true,
				override_notify = false,
			},
		},
	},
}
