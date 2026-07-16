 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#141316',
    base01 = '#201f22',
    base02 = '#2b292c',
    base03 = '#948f98',
    base04 = '#cac4ce',
    base05 = '#e6e1e5',
    base06 = '#e6e1e5',
    base07 = '#e6e1e5',
    base08 = '#ffb4ab',
    base09 = '#f0b7cf',
    base0A = '#cbc3d7',
    base0B = '#cdc0ed',
    base0C = '#f0b7cf',
    base0D = '#cdc0ed',
    base0E = '#cbc3d7',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e6e1e5',          bg = '#141316' })
  hi('TelescopeBorder',         { fg = '#948f98',             bg = '#141316' })
  hi('TelescopePromptNormal',   { fg = '#e6e1e5',          bg = '#141316' })
  hi('TelescopePromptBorder',   { fg = '#948f98',             bg = '#141316' })
  hi('TelescopePromptPrefix',   { fg = '#cdc0ed',             bg = '#141316' })
  hi('TelescopePromptCounter',  { fg = '#cac4ce',  bg = '#141316' })
  hi('TelescopePromptTitle',    { fg = '#141316',             bg = '#cdc0ed' })
  hi('TelescopePreviewTitle',   { fg = '#141316',             bg = '#cbc3d7' })
  hi('TelescopeResultsTitle',   { fg = '#141316',             bg = '#f0b7cf' })
  hi('TelescopeSelection',      { fg = '#e6e1e5',          bg = '#2b292c' })
  hi('TelescopeSelectionCaret', { fg = '#cdc0ed',             bg = '#2b292c' })
  hi('TelescopeMatching',       { fg = '#cdc0ed',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
