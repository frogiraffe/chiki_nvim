return {
    {
        "3rd/image.nvim",
        build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
        opts = {
            backend = "kitty",
            processor = "magick_cli",
            integrations = {},                        -- do whatever you want with image.nvim's integrations
            max_width = 100,                          -- tweak to preference
            max_height = 12,                          -- ^
            max_height_window_percentage = math.huge, -- this is necessary for a good experience
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true,
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        }
    },
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            -- these are examples, not defaults. Please see the readme
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_image_location = "virt"
            -- vim.g.molten_virt_text_output = true
            -- vim.g.molten_output_virt_lines = true
            -- vim.g.molten_cover_empty_lines = true
            -- vim.g.molten_auto_image_popup = false
            vim.g.molten_output_win_max_height = 20
            vim.keymap.set("n", "<localleader>ri", ":MoltenInit<CR>",
                { silent = true, desc = "Initialize the plugin" })
            vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>",
                { silent = true, desc = "run operator selection" })
            vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>",
                { silent = true, desc = "evaluate line" })
            vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>",
                { silent = true, desc = "re-evaluate cell" })
            vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
                { silent = true, desc = "evaluate visual selection" })
            vim.keymap.set("n", "<localleader>rd", ":MoltenDelete<CR>",
                { silent = true, desc = "molten delete cell" })
            vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>",
                { silent = true, desc = "hide output" })
            vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>",
                { silent = true, desc = "show/enter output" })
        end,
    },
}
