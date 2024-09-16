return {
  -- {
  -- 	"sainnhe/gruvbox-material",
  -- 	lazy = false,
  -- 	priority = 1000,
  -- 	config = function()
  -- 		vim.g.gruvbox_material_better_performance = true
  -- 		vim.g.gruvbox_material_background = "hard"
  -- 		vim.g.gruvbox_material_transparent_background = 0
  -- 		vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
  -- 		vim.cmd("colorscheme gruvbox-material")
  -- 	end,
  -- },
  -- {
  -- "rebelot/kanagawa.nvim",
  -- 	lazy = false,
  -- 	priority = 1000,
  -- 	config = function()
  -- 		require('kanagawa').setup({
  -- 			transparent = true,
  -- 		})
  -- 		vim.cmd("colorscheme kanagawa-dragon")
  -- 	end,
  -- }
  -- {
  -- 	"nyoom-engineering/oxocarbon.nvim",
  -- 	config = function()
  -- 		vim.opt.background = "dark"
  -- 		vim.cmd.colorscheme "oxocarbon"
  -- 	end,
  -- 	-- Add in any other configuration;
  -- 	--   event = foo,
  -- 	--   config = bar
  -- 	--   end,
  -- }
  -- {
  -- 	"catppuccin/nvim",
  -- 	name = "catppuccin",
  -- 	priority = 1000,
  -- 	config = function()
  -- 		require("catppuccin").setup({
  -- 			flavour = "mocha",
  -- 			term_colors = true,
  -- 			-- transparent_background = true,
  -- 			integrations = {
  -- 				barbar = true,
  -- 			}
  --
  -- 		})
  -- 		vim.cmd.colorscheme "catppuccin"
  -- 	end
  -- },
  {
    "nyoom-engineering/oxocarbon.nvim",
    -- Add in any other configuration;
    --   event = foo,
    --   config = bar
    --   end,
    config = function()
      vim.cmd.colorscheme "oxocarbon"
    end
  }
}
