return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-web-devicons" },
		keys = {
			{ "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
			{ "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
			{
				"<leader>b",
				"<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
				desc = "Switch Buffer",
			},
			{ "<leader>/",   "<cmd>FzfLua live_grep<cr>",             desc = "Grep (Root Dir)" },
			{ "<leader>ff",  "<cmd>FzfLua files<cr>",                 desc = "Find Files (Root Dir)" },
			{ "<leader>fF",  "<cmd>FzfLua files cwd=<cr>",            desc = "Find Files (cwd)" },
			{ "<leader>fg",  "<cmd>FzfLua git_files<cr>",             desc = "Find Files (git-files)" },
			{ "<leader>fr",  "<cmd>FzfLua oldfiles<cr>",              desc = "Recent" },
			-- git
			{ "<leader>gc",  "<cmd>FzfLua git_commits<CR>",           desc = "Commits" },
			{ "<leader>gs",  "<cmd>FzfLua git_status<CR>",            desc = "Status" },
			-- search
			{ '<leader>sr"', "<cmd>FzfLua registers<cr>",             desc = "Registers" },
			{ "<leader>sa",  "<cmd>FzfLua autocmds<cr>",              desc = "Auto Commands" },
			{ "<leader>sb",  "<cmd>FzfLua grep_curbuf<cr>",           desc = "Buffer" },
			{ "<leader>sc",  "<cmd>FzfLua command_history<cr>",       desc = "Command History" },
			{ "<leader>sC",  "<cmd>FzfLua commands<cr>",              desc = "Commands" },
			{ "<leader>sd",  "<cmd>FzfLua diagnostics_document<cr>",  desc = "Document Diagnostics" },
			{ "<leader>sD",  "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
			{ "<leader>sh",  "<cmd>FzfLua help_tags<cr>",             desc = "Help Pages" },
			{ "<leader>sH",  "<cmd>FzfLua highlights<cr>",            desc = "Search Highlight Groups" },
			{ "<leader>sj",  "<cmd>FzfLua jumps<cr>",                 desc = "Jumplist" },
			{ "<leader>sk",  "<cmd>FzfLua keymaps<cr>",               desc = "Key Maps" },
			{ "<leader>sl",  "<cmd>FzfLua loclist<cr>",               desc = "Location List" },
			{ "<leader>sM",  "<cmd>FzfLua man_pages<cr>",             desc = "Man Pages" },
			{ "<leader>,",   "<cmd>FzfLua marks<cr>",                 desc = "Jump to Mark" },
			{ "<leader>sR",  "<cmd>FzfLua resume<cr>",                desc = "Resume" },
			{ "<leader>sq",  "<cmd>FzfLua quickfix<cr>",              desc = "Quickfix List" },
			{
				"<leader>ss",
				function()
					require("fzf-lua").lsp_document_symbols()
				end,
				desc = "Goto Symbol",
			},
			{
				"<leader>sS",
				function()
					require("fzf-lua").lsp_live_workspace_symbols()
				end,
				desc = "Goto Symbol (Workspace)",
			},
		},
		opts = {
			oldfiles = {
				-- In Telescope, when I used <leader>fr, it would load old buffers.
				-- fzf lua does the same, but by default buffers visited in the current
				-- session are not included. I use <leader>fr all the time to switch
				-- back to buffers I was just in. If you missed this from Telescope,
				-- give it a try.
				include_current_session = true,
			},
			previewers = {
				builtin = {
					-- fzf-lua is very fast, but it really struggled to preview a couple files
					-- in a repo. Those files were very big JavaScript files (1MB, minified, all on a single line).
					-- It turns out it was Treesitter having trouble parsing the files.
					-- With this change, the previewer will not add syntax highlighting to files larger than 100KB
					-- (Yes, I know you shouldn't have 100KB minified files in source control.)
					syntax_limit_b = 1024 * 100, -- 100KB
				},
			},
			grep = {
				-- One thing I missed from Telescope was the ability to live_grep and then
				-- run a filter on the filenames.
				-- Ex: Find all occurrences of "enable" but only in the "plugins" directory.
				-- With this change, I can sort of get the same behaviour in live_grep.
				-- ex: > enable --*/plugins/*
				-- I still find this a bit cumbersome. There's probably a better way of doing this.
				rg_glob = true, -- enable glob parsing
				glob_flag = "--iglob", -- case insensitive globs
				glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
			},
		},
		config = function()
			require("fzf-lua").setup({})
			require("fzf-lua").register_ui_select(function(_, items)
				local min_h, max_h = 0.15, 0.70
				local h = (#items + 4) / vim.o.lines
				if h < min_h then
					h = min_h
				elseif h > max_h then
					h = max_h
				end
				return { winopts = { height = h, width = 0.60, row = 0.40 } }
			end)
		end,
	},
}
