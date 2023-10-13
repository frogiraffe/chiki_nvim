return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "find files" } },
		{ "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "grep" } },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "buffers" } },
		{ "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "marks" } },
		{

			"<leader>fcs",
			"<cmd>Telescope grep_string<cr>",
			{ desc = "grep the string under the cursor" },
		},
		{ "<leader>fgc", "<cmd>Telescope git_commits<cr>", { desc = "git commits" } },
		{ "<leader>fgs", "<cmd>Telescope git_status<cr>", { desc = "git status" } },
		{ "<leader>fgb", "<cmd>Telescope git_branches<cr>", { desc = "git branches" } },
		{ "<leader>fgf", "<cmd>Telescope git_files<cr>", { desc = "git files" } },
		{ "<leader>fp", "<cmd>Telescope projects<cr>", { desc = "projects" } },
		{
			"<leader>fy",
			'<cmd>lua require("telescope").extensions.neoclip.default()<CR>',
			{ desc = "yank" },
		},
		{
			"<leader>?",
			"<cmd>Telescope oldfiles<cr>",
			{ desc = "[?] Find recently opened files" },
		},
		{ "<leader>fu", "<cmd>:Telescope undo<CR>", { desc = "undo" } },
	},
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
				-- file_ignore_patterns = {
				-- 	"node_modules",
				-- 	"go/pkg/*",
				-- 	".npm",
				-- 	".cargo",
				-- 	".cache",
				-- 	".rustup",
				-- 	".ssh",
				-- 	".mozilla",
				-- 	".gnupg",
				-- 	"repos",
				-- 	".local",
				-- 	"steam",
				-- 	"library",
				-- },
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
		require("telescope").load_extension("projects")
	end,
}
