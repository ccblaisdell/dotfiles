MiniDeps.later(function()
  -- Make themes available
  MiniDeps.add({ source = 'olivercederborg/poimandres.nvim' })
  require('poimandres').setup({})

  MiniDeps.add({ source = 'catppuccin/nvim' })
  require('catppuccin').setup({})

  -- Set default theme
  vim.cmd('colorscheme poimandres')
end)
