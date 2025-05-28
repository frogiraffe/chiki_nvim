return {
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require('kanagawa').setup({
                theme = "dragon",
                -- transparent = true,
                background = {
                    dark = "dragon"
                }
            })
        end
    }
}
