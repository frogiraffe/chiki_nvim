return {
  {
    "epwalsh/obsidian.nvim",
    lazy = true,
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre /home/chiki/docs/notes/**.md",
      "BufNewFile /home/chiki/docs/notes/**.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require('obsidian').setup({
        dir = "/home/chiki/docs/notes/",
        completion = {
          nvim_cmp = true,
          min_chars = 2,
          prepend_note_id = true
        },
        mappings = {
          ["gf"] = {
            action = function()
              return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
        },
        overwrite_mappings = true,
        disable_frontmatter = true,

        backlinks = {
          height = 10,
          wrap = true,
        },

        follow_url_func = function(url)
          vim.fn.jobstart({ "xdg-open", url }) -- linux
        end,

        finder = "telescope.nvim",

        sort_by = "modified",
        sort_reversed = true,
      })
    end,
  },
  {
    "toppair/peek.nvim",
    build = 'deno task --quiet build:fast',
    event = { "VeryLazy" },
    config = function()
      require('peek').setup({
      })

      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,

  },
  -- { "lervag/vimtex" },
  -- {
  --   "evesdropper/luasnip-latex-snippets.nvim",
  -- }
  -- {
  --   "iurimateus/luasnip-latex-snippets.nvim",
  --   -- vimtex isn't required if using treesitter
  --   requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
  --   config = function()
  --     require('luasnip-latex-snippets').setup({
  --       allow_on_markdown = true,
  --     })
  --     -- or setup({ use_treesitter = true })
  --     require("luasnip").config.setup ({ enable_autosnippets = true })
  --   end,
  -- }
}
