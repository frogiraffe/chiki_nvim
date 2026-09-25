-- blink.cmp is LazyVim's default completion engine; LuaSnip comes from the
-- coding.luasnip extra. Only personal behaviour is configured here.
return {
	{
		"L3MON4D3/LuaSnip",
		version = "2.*",
		opts = {
			enable_autosnippets = true,
			update_events = "TextChanged,TextChangedI",
		},
		config = function(_, opts)
			require("luasnip").setup(opts)
			-- Lua snippets are loaded per filetype on demand, so the large LaTeX
			-- snippet file is only read when a tex buffer is opened.
			require("luasnip.loaders.from_lua").lazy_load({
				paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
			})
		end,
	},
	{
		"saghen/blink.cmp",
		---@module 'blink.cmp'
		---@param opts blink.cmp.Config
		opts = function(_, opts)
			opts.keymap = {
				preset = "default",
				["<Tab>"] = {
					function()
						local ls = require("luasnip")
						if ls.locally_jumpable(1) then
							vim.schedule(function()
								ls.jump(1)
							end)
							return true
						end
					end,
					"fallback",
				},
				["<S-Tab>"] = {
					function()
						local ls = require("luasnip")
						if ls.locally_jumpable(-1) then
							vim.schedule(function()
								ls.jump(-1)
							end)
							return true
						end
					end,
					"fallback",
				},
			}

			opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
				ghost_text = { enabled = true },
				documentation = { auto_show = false, auto_show_delay_ms = 500 },
			})
			opts.signature = { enabled = true }
			-- Stock blink cmdline behaviour/keys (LazyVim unmaps <Left>/<Right>).
			opts.cmdline = { enabled = true }
			opts.fuzzy = { implementation = "prefer_rust_with_warning" }

			-- The sql extra adds Dadbod to every filetype; it is only useful in SQL
			-- buffers, where per_filetype below already enables it.
			opts.sources.default = vim.tbl_filter(function(source)
				return source ~= "dadbod"
			end, opts.sources.default or {})

			local sql_sources = { "snippets", "dadbod", "buffer" }
			opts.sources.per_filetype = vim.tbl_extend("force", opts.sources.per_filetype or {}, {
				-- Dadbod owns schema-aware SQL completion.
				sql = sql_sources,
				mysql = sql_sources,
				plsql = sql_sources,
			})
			return opts
		end,
	},
}
