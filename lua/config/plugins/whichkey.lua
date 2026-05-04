return {
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern", -- modern looks better on Nvim 0.10+
			delay = 0,
			icons = {
				mappings = vim.g.have_nerd_font,
			},
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader>b", group = "󰓩 [B]uffer" },
					{ "<leader>c", group = "󰅩 [C]ode" },
					{ "<leader>f", group = "󰍉 [F]ind" },
					{ "<leader>g", group = "󰊢 [G]it" },
					{ "<leader>h", group = "󰊢 Git [H]unk" },
					{ "<leader>n", group = "󰵅 [N]otifications" },
					{ "<leader>o", group = "󰭟 [O]utline/Aerial" },
					{ "<leader>p", group = "󰑮 [P]rofiler" },
					{ "<leader>s", group = "󰭎 [S]earch" },
					{ "<leader>t", group = "󱊔 [T]oggle" },
					{ "<leader>u", group = "󰙵 [U]I" },
					{ "<leader>x", group = "󰒡 [X] Troubleshoot" },
					{ "<leader>z", group = "󰫙 [Z]en Mode" },
				},
			},
		},
	},
}
