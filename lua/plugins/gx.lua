return {
	{
		"chrishrb/gx.nvim",
		keys = { { "gX", "<cmd>Browse<cr>", mode = { "n", "x" }, desc = "Open URL/link under cursor" } },
		cmd = { "Browse" },
		init = function()
			vim.g.netrw_nogx = 1 -- disable netrw gx
		end,
		config = function()
			require("gx").setup({
				open_browser_app = "xdg-open", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
				open_browser_args = {}, -- specify any arguments, such as --background for macOS' "open".

				open_callback = function(url)
					vim.fn.setreg("+", url) -- for example, you can set the url to clipboard here
				end,

				select_prompt = true, -- shows a prompt when multiple handlers match; disable to auto-select the top one

				handlers = {
					plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
					github = true, -- open github issues
					brewfile = true, -- open Homebrew formulaes and casks
					package_json = true, -- open dependencies from package.json
					search = true, -- search the web/selection on the web if nothing else is found
					go = true, -- open pkg.go.dev from an import statement (uses treesitter)
					rust = { -- custom handler to open rust's cargo packages
						name = "rust", -- set name of handler
						filetype = { "toml" }, -- you can also set the required filetype for this handler
						filename = "Cargo.toml", -- or the necessary filename
						handle = function(mode, line, _)
							local crate = require("gx.helper").find(line, mode, "(%w+)%s-=%s")

							if crate then
								return "https://crates.io/crates/" .. crate
							end
						end,
					},
				},
				handler_options = {
					search_engine = "https://search.brave.com/search?q=", -- Use Brave search as default
					select_for_search = false,

					git_remotes = { "upstream", "origin" },
					git_remote_push = false,
				},
			})
		end,
	},
}
