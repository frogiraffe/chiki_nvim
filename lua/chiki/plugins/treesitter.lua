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
                                set_jumps = true, -- whether to set jumps in the jumplist
                                goto_next_start = {
                                    ["]m"] = "@function.outer",
                                    ["]]"] = { query = "@class.outer", desc = "Next class start" },
                                    --
                                    -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                                    ["]o"] = "@loop.*",
                                    -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                                    --
                                    -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                                    -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
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
                                }, -- Below will go to either the start or the end, whichever is closer. Use if you want more granular movements
                                -- Make it even more gradual by adding multiple queries and regex.
                                goto_next = {
                                    ["]b"] = "@conditional.outer",
                                },
                                goto_previous = {
                                    ["[b"] = "@conditional.outer",
                                },
                            },
                            select = {
                                enable = true,

                                -- Automatically jump forward to textobj, similar to targets.vim
                                lookahead = true,

                                keymaps = {
                                    -- You can use the capture groups defined in textobjects.scm
                                    ["af"] = "@function.outer",
                                    ["if"] = "@function.inner",
                                    ["ac"] = "@class.outer",
                                    -- You can optionally set descriptions to the mappings (used in the desc parameter of
                                    -- nvim_buf_set_keymap) which plugins like which-key display
                                    ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                                    -- You can also use captures from other query groups like `locals.scm`
                                    ["as"] = {
                                        query = "@scope",
                                        query_group = "locals",
                                        desc = "Select language scope",
                                    },
                                },
                                -- You can choose the select mode (default is charwise 'v')
                                --
                                -- Can also be a function which gets passed a table with the keys
                                -- * query_string: eg '@function.inner'
                                -- * method: eg 'v' or 'o'
                                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                                -- mapping query_strings to modes.
                                selection_modes = {
                                    ["@parameter.outer"] = "v", -- charwise
                                    ["@function.outer"] = "V",  -- linewise
                                    ["@class.outer"] = "<c-v>", -- blockwise
                                },
                                -- If you set this to `true` (default is `false`) then any textobject is
                                -- extended to include preceding or succeeding whitespace. Succeeding
                                -- whitespace has priority in order to act similarly to eg the built-in
                                -- `ap`.
                                --
                                -- Can also be a function which gets passed a table with the keys
                                -- * query_string: eg '@function.inner'
                                -- * selection_mode: eg 'v'
                                -- and should return true of false
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
                            prev_selection = ",", -- (Optional) keymap to select the previous selection
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
                config = function() require("treesj").setup({ max_join_length = 240 }) end,
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
                -- matchup = { enable = true },
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
                        scope_incremental = "false",
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
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    },
}
