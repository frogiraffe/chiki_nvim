local keymap = vim.keymap.set
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("n", "J", "mzJ'z")
keymap("v", "K", ":m '<-2<CR>gv=gv")
keymap('n', 'n', 'nzzzv')
keymap('n', 'N', 'Nzzzv')
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("x", "<leader>p", [["_dP]], { desc = "paste and replace" })
keymap({ "v" }, "<leader>d", [["_d]], { desc = "delete to void" })
keymap("i", "<C-c>", "<Esc>")
keymap("n", "U", "<C-r>")
keymap('v', '<leader>y', '"+y')
keymap('n', '<leader>q', '<cmd>:bd<CR>')
keymap('n', '<leader>w', '<cmd>:w<CR>')
local function open_tab_silent(node)
    local api = require("nvim-tree.api")

    api.node.open.tab(node)
    vim.cmd.tabprev()
end
keymap('n', 'T', open_tab_silent, { desc = ('Open Tab Silent') })
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
vim.api.nvim_create_autocmd('LspAttach', {
    desc = "lsp actions",
    callback = function(event)
        keymap('n', 'K', '<cmd>:lua vim.lsp.buf.hover()<CR>', { desc = "hover doc" })
        keymap('n', 'gd', '<cmd>:lua vim.lsp.buf.definition()<CR>', { desc = "go to definition" })
        keymap('n', 'gD', '<cmd>:lua vim.lsp.buf.declaration()<CR>', { desc = "go to declaration" })
        keymap('n', 'gi', '<cmd>:lua vim.lsp.buf.implementation()<CR>', { desc = "go to implementation" })
        keymap('n', 'go', '<cmd>:lua vim.lsp.buf.type_definition()<CR>', { desc = "go to type definition" })
        keymap('n', 'gr', '<cmd>:lua vim.lsp.buf.references()<CR>', { desc = " go to references" })
        keymap('n', 'gs', '<cmd>:lua vim.lsp.buf.signature_help()<CR>', { desc = "show signature help" })
        keymap('n', '[d', '<cmd>:lua vim.diagnostic.goto_prev()<CR>', { desc = "go to previous diagnostic" })
        keymap('n', ']d', '<cmd>:lua vim.diagnostic.goto_next()<CR>', { desc = "go to next diagnostic" })
        keymap('n', 'gl', '<cmd>:lua vim.diagnostic.open.float()()<CR>', { desc = "open diagnostic float" })
        keymap('n', "<leader>gf", "<cmd>lua vim.lsp.buf.format()<CR>", { desc = "format" })
        keymap('n', 'gR', '<cmd>:lua vim.lsp.buf.rename()<CR>', { desc = "rename" })
        keymap('n', 'ca', '<cmd>:lua vim.lsp.buf.code_action()<CR>', { desc = "code action" })
    end,
})
