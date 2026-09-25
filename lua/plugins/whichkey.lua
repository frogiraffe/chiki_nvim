return {
	{
		"folke/which-key.nvim",
		opts = function(_, opts)
			opts.preset = "modern"
			opts.delay = 0
			opts.icons = vim.tbl_deep_extend("force", opts.icons or {}, { mappings = vim.g.have_nerd_font })

			-- <leader>w saves the buffer here, so drop LazyVim's "windows" group
			-- (it proxies <c-w> and would shadow the save mapping).
			local function strip(spec)
				for i = #spec, 1, -1 do
					local item = spec[i]
					if type(item) == "table" then
						if item[1] == "<leader>w" then
							table.remove(spec, i)
						else
							strip(item)
						end
					end
				end
			end
			opts.spec = opts.spec or {}
			strip(opts.spec)

			table.insert(opts.spec, {
				mode = { "n", "v" },
				{ "<leader>b", group = "󰓩 [B]uffer" },
				{ "<leader>c", group = "󰅩 [C]ode" },
				{ "<leader>d", group = "󰆼 [D]atabase" },
				{ "<leader>f", group = "󰍉 [F]ind" },
				{ "<leader>g", group = "󰊢 [G]it" },
				{ "<leader>n", group = "󰵅 [N]otifications" },
				{ "<leader>N", group = "󰈤 [N]eovim" },
				{ "<leader>o", group = "󰭟 [O]utline/Aerial" },
				{ "<leader>p", group = "󰑮 [P]rofiler" },
				{ "<leader>s", group = "󰭎 [S]earch" },
				{ "<leader>j", group = "󰗈 [J]oin/Split" },
				{ "<leader>u", group = "󰙵 [U]I" },
				{ "<leader>x", group = "󰒡 [X] Troubleshoot" },
				{ "<leader>z", group = "󰫙 [Z]en Mode" },
			})
		end,
	},
}
