return {
	{ -- Highlight, edit, and navigate code (nvim-treesitter `main` branch / rewrite)
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		-- Load eagerly so the FileType autocmd below is registered before the
		-- first buffer's FileType fires (otherwise the first file gets no highlight).
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			ts.setup()

			local ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"rust",
				"python",
				"ron", -- Rust Object Notation
				"regex",
				"yaml",
				"toml",
			}

			-- Install any parsers that aren't present yet (async).
			local installed = ts.get_installed()
			local missing = vim.tbl_filter(function(lang)
				return not vim.tbl_contains(installed, lang)
			end, ensure_installed)
			if #missing > 0 then
				ts.install(missing)
			end

			-- Enable highlighting (and TS folding) per buffer.
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
				callback = function(args)
					local buf = args.buf
					local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
					if not lang or not vim.tbl_contains(ts.get_installed(), lang) then
						return
					end

					-- Skip very large files (> 100 KB) for performance.
					local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > 100 * 1024 then
						return
					end

					if pcall(vim.treesitter.start, buf, lang) then
						-- Treesitter-based folding (foldlevel=99 keeps everything open).
						vim.wo.foldmethod = "expr"
						vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
						-- Indentation is left to the default engine (matching the
						-- previous config). To try experimental TS indent, uncomment:
						-- vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}
