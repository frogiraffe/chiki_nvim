return {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        -- Lua
        vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "trouble toggle" },
            { silent = true, noremap = true }
        )
        vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "trouble workspace" },
            { silent = true, noremap = true }
        )
        vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "trouble document" },
            { silent = true, noremap = true }
        )
    end,
}
