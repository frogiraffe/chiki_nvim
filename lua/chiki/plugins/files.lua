local keymap = vim.keymap.set
local function open_tab_silent(node)
	local api = require("nvim-tree.api")

	api.node.open.tab(node)
	vim.cmd.tabprev()
end
keymap("n", "T", open_tab_silent, { desc = "Open Tab Silent" })
function find_directory_and_focus()
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local function open_nvim_tree(prompt_bufnr, _)
		actions.select_default:replace(function()
			local api = require("nvim-tree.api")

			actions.close(prompt_bufnr)
			local selection = action_state.get_selected_entry()
			api.tree.open()
			api.tree.find_file(selection.cwd .. "/" .. selection.value)
		end)
		return true
	end
	require("telescope.builtin").find_files({
		find_command = { "fd", "--type", "directory", "--hidden", "--exclude", ".git/*" },
		attach_mappings = open_nvim_tree,
	})
end

keymap("n", "<leader>fd", find_directory_and_focus, { desc = "find dir in project" })
return {
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>e", "<cmd>:NvimTreeToggle<CR>", { desc = "tree toggle" } },
			{ "<leader>fe", "<cmd>:NvimTreeFindFileToggle<CR>", { desc = "tree toggle" } },
		},
		config = function()
			local function open_tab_silent(node)
				local api = require("nvim-tree.api")

				api.node.open.tab(node)
				vim.cmd.tabprev()
			end
			require("nvim-tree").setup({
				sync_root_with_cwd = false,
				respect_buf_cwd = false,
				renderer = {},
				view = {
					adaptive_size = false,
					side = "left",
					width = 30,
					preserve_window_proportions = true,
				},
			})
			vim.keymap.set("n", "T", open_tab_silent, { desc = "Open Tab Silent" })
		end,
	},
}
