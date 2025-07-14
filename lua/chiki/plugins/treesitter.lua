return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                config = function()
                    require("nvim-treesitter.configs").setup({
                        textobjects = {
                            swap = {
                                enable = true,
                                swap_previous = {
                                    ["<leader>A"] = "@parameter.inner",
                                },
                                swap_next = {
                                    ["<leader>a"] = "@parameter.inner",
                                },
                            },
                            move = {
                                enable = true,
                                set_jumps = true,
                                goto_next_start = {
                                    ["]m"] = "@function.outer",
                                    ["]]"] = { query = "@class.outer", desc = "Next class start" },
                                    ["]o"] = "@loop.*",
                                    ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                                    ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                                },
                                goto_next_end = {
                                    ["]M"] = "@function.outer",
                                    ["]["] = "@class.outer",
                                },
                                goto_previous_start = {
                                    ["[m"] = "@function.outer",
                                    ["[["] = "@class.outer",
                                },
                                goto_previous_end = {
                                    ["[M"] = "@function.outer",
                                    ["[]"] = "@class.outer",
                                },
                                goto_next = {
                                    ["]b"] = "@conditional.outer",
                                },
                                goto_previous = {
                                    ["[b"] = "@conditional.outer",
                                },
                            },
                            select = {
                                enable = true,
                                lookahead = true,
                                keymaps = {
                                    ["af"] = "@function.outer",
                                    ["if"] = "@function.inner",
                                    ["ac"] = "@class.outer",
                                    ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                                    ["as"] = {
                                        query = "@scope",
                                        query_group = "locals",
                                        desc = "Select language scope",
                                    },
                                },
                                selection_modes = {
                                    ["@parameter.outer"] = "v",
                                    ["@function.outer"] = "V",
                                    ["@class.outer"] = "<c-v>",
                                },
                                include_surrounding_whitespace = true,
                            },
                        },
                    })
                end,
            },
            {
                "RRethy/nvim-treesitter-textsubjects",
                config = function()
                    require("nvim-treesitter.configs").setup({
                        textsubjects = {
                            enable = true,
                            prev_selection = ",",
                            keymaps = {
                                ["<CR>"] = "textsubjects-smart",
                                [";"] = "textsubjects-container-outer",
                                ["i"] = "textsubjects-container-inner",
                            },
                        },
                    })
                end,
            },
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                config = function()
                    require("ts_context_commentstring").setup({
                        enable_autocmd = true,
                    })
                end,
            },
            {
                "Wansmer/treesj",
                keys = { "<space>m" },
                dependencies = { "nvim-treesitter/nvim-treesitter" },
                config = function()
                    require("treesj").setup({ max_join_length = 240 })
                end,
            },
            {
                "RRethy/nvim-treesitter-endwise",
                config = function()
                    require("nvim-treesitter.configs").setup({
                        endwise = {
                            enable = true,
                        },
                    })
                end,
            },
        },
        config = function()
            require("nvim-treesitter.install").update({ with_sync = true })
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "css",
                    "html",
                    "javascript",
                    "lua",
                    "nix",
                    "python",
                    "tsx",
                    "typescript",
                    "vim",
                    "rust",
                    "bash",
                    "r",
                    "markdown",
                    "markdown_inline",
                    "rnoweb",
                },
                context_commentstring = { enable = true },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "markdown" },
                },
                incremental_selection = {
                    enable = false,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = ";",
                        scope_incremental = false,
                        node_decremental = ".",
                    },
                },
                autotag = { enable = true },
            })
        end,
    },
    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = (vim.fn.has("nvim-0.10.0") == 1),
    },
}
