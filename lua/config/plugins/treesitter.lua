return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		version = false,
		-- Unlike the previous eager setup, load Treesitter when a real file is
		-- opened. The current buffer is attached explicitly below because its
		-- FileType event may have fired before BufReadPost.
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			ts.setup()

			local ensure_installed = {
				"bash",
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

			local function attach(buf)
				if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_is_loaded(buf) then
					return
				end
				if vim.bo[buf].buftype ~= "" then
					return
				end

				local ft = vim.bo[buf].filetype
				local lang = ft ~= "" and vim.treesitter.language.get_lang(ft) or nil
				if not lang or not installed[lang] then
					return
				end

				-- Snacks.bigfile handles the rest of the editor; avoid parser cost for
				-- large source/data files as well.
				local name = vim.api.nvim_buf_get_name(buf)
				local ok, stats = pcall(vim.uv.fs_stat, name)
				if ok and stats and stats.size > 100 * 1024 then
					return
				end

				if pcall(vim.treesitter.start, buf, lang) then
					vim.wo.foldmethod = "expr"
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				end
			end

			vim.api.nvim_create_autocmd("FileType", {
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
