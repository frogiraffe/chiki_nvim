return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		-- LazyVim currently pins the last compatible main-branch commit on
		-- Neovim 0.11; Neovim 0.12+ can track current main safely.
		commit = vim.fn.has("nvim-0.12") == 0 and "7caec274fd19c12b55902a5b795100d21531391f" or nil,
		version = false,
		-- Load Treesitter when a real file is opened instead of on the dashboard
		-- hot path. The current buffer is attached explicitly below because its
		-- FileType event may already have fired before BufReadPost.
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			ts.setup()

			local ensure_installed = {
				"bash",
				"bibtex",
				"c",
				"cpp",
				"css",
				"csv",
				"diff",
				"dockerfile",
				"go",
				"html",
				"javascript",
				"json",
				"latex",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"r",
				"regex",
				"rnoweb",
				"ron",
				"rust",
				"sql",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			}

			local installed = {}
			local function refresh_installed()
				installed = {}
				for _, lang in ipairs(ts.get_installed()) do
					installed[lang] = true
				end
			end
			refresh_installed()

			local function set_folds(buf)
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
						vim.wo[win].foldmethod = "expr"
						vim.wo[win].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					end
				end
			end

			local function attach(buf)
				if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_is_loaded(buf) then
					return
				end
				if vim.bo[buf].buftype ~= "" then
					return
				end

				local ft = vim.bo[buf].filetype
				-- VimTeX owns LaTeX syntax highlighting. The parser is still installed
				-- for consumers that need it, but attaching two highlighters is noisy.
				if ft == "tex" or ft == "plaintex" or ft == "latex" then
					return
				end

				local lang = ft ~= "" and vim.treesitter.language.get_lang(ft) or nil
				if not lang or not installed[lang] then
					return
				end

				-- Snacks.bigfile is the single large-file gate. It changes oversized
				-- buffers to the `bigfile` filetype and prevents LSP/Treesitter work,
				-- avoiding a second, much lower size threshold here.
				if pcall(vim.treesitter.start, buf, lang) then
					set_folds(buf)
				end
			end

			vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
				group = vim.api.nvim_create_augroup("chiki_treesitter", { clear = true }),
				callback = function(event)
					attach(event.buf)
				end,
			})

			local missing = vim.tbl_filter(function(lang)
				return not installed[lang]
			end, ensure_installed)
			if #missing > 0 then
				local task = ts.install(missing, { summary = true })
				if task and task.await then
					task:await(function()
						refresh_installed()
						vim.schedule(function()
							for _, buf in ipairs(vim.api.nvim_list_bufs()) do
								attach(buf)
							end
						end)
					end)
				end
			end

			vim.schedule(function()
				attach(vim.api.nvim_get_current_buf())
			end)
		end,
	},
}
