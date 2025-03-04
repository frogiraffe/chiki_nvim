return {
    {
        "mfussenegger/nvim-lint",
        opts = {
            -- Event to trigger linters
            events = { "BufWritePost", "BufReadPost", "InsertLeave" },
            linters_by_ft = {
                fish = { "fish" },
                -- Use the "*" filetype to run linters on all filetypes.
                -- ['*'] = { 'global linter' },
                -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
                -- ['_'] = { 'fallback linter' },
                -- ["*"] = { "typos" },
            },
        },
        config = function()
            require("lint").linters_by_ft = {
                lua = { "luacheck" },
                go = { "golangcilint" },
                -- markdown = { "markdownlint" --[[ "write-good" ]] },
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },


            }
        end,
    },
}
