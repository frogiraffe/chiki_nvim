return {
  {
    "rebelot/kanagawa.nvim",
    config = function()
      vim.cmd("colorscheme kanagawa")
      require('kanagawa').setup({
        theme = "dragon",
        background = {
          dark = "dragon"
        }
      })
    end
  }
}
