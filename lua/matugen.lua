 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1a1111',
    base01 = '#271d1c',
    base02 = '#322727',
    base03 = '#a48b89',
    base04 = '#dcc0be',
    base05 = '#f1dedd',
    base06 = '#f1dedd',
    base07 = '#f1dedd',
    base08 = '#ffb4ab',
    base09 = '#f7bb6e',
    base0A = '#f7b6b2',
    base0B = '#ffb3af',
    base0C = '#f7bb6e',
    base0D = '#ffb3af',
    base0E = '#f7b6b2',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f1dedd',          bg = '#1a1111' })
  hi('TelescopeBorder',         { fg = '#a48b89',             bg = '#1a1111' })
  hi('TelescopePromptNormal',   { fg = '#f1dedd',          bg = '#1a1111' })
  hi('TelescopePromptBorder',   { fg = '#a48b89',             bg = '#1a1111' })
  hi('TelescopePromptPrefix',   { fg = '#ffb3af',             bg = '#1a1111' })
  hi('TelescopePromptCounter',  { fg = '#dcc0be',  bg = '#1a1111' })
  hi('TelescopePromptTitle',    { fg = '#1a1111',             bg = '#ffb3af' })
  hi('TelescopePreviewTitle',   { fg = '#1a1111',             bg = '#f7b6b2' })
  hi('TelescopeResultsTitle',   { fg = '#1a1111',             bg = '#f7bb6e' })
  hi('TelescopeSelection',      { fg = '#f1dedd',          bg = '#322727' })
  hi('TelescopeSelectionCaret', { fg = '#ffb3af',             bg = '#322727' })
  hi('TelescopeMatching',       { fg = '#ffb3af',             bold = true })
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
