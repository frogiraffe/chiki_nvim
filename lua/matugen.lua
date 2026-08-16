 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#131317',
    base01 = '#1f1f23',
    base02 = '#2a2a2e',
    base03 = '#90909a',
    base04 = '#c7c5d1',
    base05 = '#e4e1e7',
    base06 = '#e4e1e7',
    base07 = '#e4e1e7',
    base08 = '#ffb4ab',
    base09 = '#f4b2e4',
    base0A = '#c3c4e1',
    base0B = '#bcc2ff',
    base0C = '#f4b2e4',
    base0D = '#bcc2ff',
    base0E = '#c3c4e1',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e4e1e7',          bg = '#131317' })
  hi('TelescopeBorder',         { fg = '#90909a',             bg = '#131317' })
  hi('TelescopePromptNormal',   { fg = '#e4e1e7',          bg = '#131317' })
  hi('TelescopePromptBorder',   { fg = '#90909a',             bg = '#131317' })
  hi('TelescopePromptPrefix',   { fg = '#bcc2ff',             bg = '#131317' })
  hi('TelescopePromptCounter',  { fg = '#c7c5d1',  bg = '#131317' })
  hi('TelescopePromptTitle',    { fg = '#131317',             bg = '#bcc2ff' })
  hi('TelescopePreviewTitle',   { fg = '#131317',             bg = '#c3c4e1' })
  hi('TelescopeResultsTitle',   { fg = '#131317',             bg = '#f4b2e4' })
  hi('TelescopeSelection',      { fg = '#e4e1e7',          bg = '#2a2a2e' })
  hi('TelescopeSelectionCaret', { fg = '#bcc2ff',             bg = '#2a2a2e' })
  hi('TelescopeMatching',       { fg = '#bcc2ff',             bold = true })
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
