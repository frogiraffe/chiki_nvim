return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.1",
	-- cmd = 'Telescope',
	-- or                              , branch = '0.1.1',
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
		"debugloop/telescope-undo.nvim",
	},
	config = function()
		local builtin = require("telescope.builtin")
		require("telescope").setup({
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter case_mode = "smart_case",
				},
				undo = {
					side_by_side = true,
					layout_strategy = "vertical",
					layout_config = {
						preview_height = 0.8,
					},
					mappings = {
						i = {
							-- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
							-- you want to replicate these defaults and use the following actions. This means
							-- installing as a dependency of telescope in it's `requirements` and loading this
							-- extension from there instead of having the separate plugin definition as outlined
							-- above.
							["<cr>"] = require("telescope-undo.actions").yank_additions,
							["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
							["<C-cr>"] = require("telescope-undo.actions").restore,
						},
					},
				},
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
				},
				live_grep = {
					additional_args = function(opts)
						return { "--hidden" }
					end,
				},
			},
			buffers = {},
			marks = {
				inital_mode = "normal",
			},
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					"go/pkg/*",
					".npm",
					".cargo",
					".cache",
					".rustup",
					".ssh",
					".mozilla",
					".gnupg",
					"repos",
					".local",
					"steam",
					"library",
				},
				mappings = {
					i = {
						["<esc>"] = require("telescope.actions").close,
					},
					n = {
						["q"] = require("telescope.actions").close,
					},
				},
			},
		})
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("undo")
		require('telescope').load_extension('projects')
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find files" })
		vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "buffers" })
		vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "marks" })
		vim.keymap.set("n", "<leader>fcs", builtin.grep_string, { desc = "grep the string under the cursor" })
		vim.keymap.set("n", "<leader>fgc", builtin.git_commits, { desc = "git commits" })
		vim.keymap.set("n", "<leader>fgs", builtin.git_status, { desc = "git status" })
		vim.keymap.set("n", "<leader>fgb", builtin.git_branches, { desc = "git branches" })
		vim.keymap.set("n", "<leader>fgf", builtin.git_files, { desc = "git files" })
		vim.keymap.set('n', '<leader>fp', '<cmd>Telescope projects<cr>', { desc = "projects" })
		vim.keymap.set(
			"n",
			"<leader>fy",
			'<cmd>lua require("telescope").extensions.neoclip.default()<CR>',
			{ desc = "yank" }
		)
		vim.keymap.set("n", "<leader>fu", "<cmd>:Telescope undo<CR>", { desc = "undo" })
	end,
}
