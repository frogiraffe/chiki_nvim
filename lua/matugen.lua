 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#101416',
    base01 = '#1d2022',
    base02 = '#272a2c',
    base03 = '#899297',
    base04 = '#bfc8cd',
    base05 = '#e0e3e5',
    base06 = '#e0e3e5',
    base07 = '#e0e3e5',
    base08 = '#ffb4ab',
    base09 = '#e2b7f6',
    base0A = '#afcbd8',
    base0B = '#87d0ef',
    base0C = '#e2b7f6',
    base0D = '#87d0ef',
    base0E = '#afcbd8',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e0e3e5',          bg = '#101416' })
  hi('TelescopeBorder',         { fg = '#899297',             bg = '#101416' })
  hi('TelescopePromptNormal',   { fg = '#e0e3e5',          bg = '#101416' })
  hi('TelescopePromptBorder',   { fg = '#899297',             bg = '#101416' })
  hi('TelescopePromptPrefix',   { fg = '#87d0ef',             bg = '#101416' })
  hi('TelescopePromptCounter',  { fg = '#bfc8cd',  bg = '#101416' })
  hi('TelescopePromptTitle',    { fg = '#101416',             bg = '#87d0ef' })
  hi('TelescopePreviewTitle',   { fg = '#101416',             bg = '#afcbd8' })
  hi('TelescopeResultsTitle',   { fg = '#101416',             bg = '#e2b7f6' })
  hi('TelescopeSelection',      { fg = '#e0e3e5',          bg = '#272a2c' })
  hi('TelescopeSelectionCaret', { fg = '#87d0ef',             bg = '#272a2c' })
  hi('TelescopeMatching',       { fg = '#87d0ef',             bold = true })
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
