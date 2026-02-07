MiniDeps.later(function()
  -- Change the theme
  -- Normally this theme is lazily loaded, but go ahead and do it now in case we initialized the editor with a markdown file
  MiniDeps.add({ source = 'catppuccin/nvim' })
  require('catppuccin').setup({})
  vim.cmd('colorscheme catppuccin')
end)

-- Wrap text at 80
vim.opt.colorcolumn = '80'
vim.opt.textwidth = 80
vim.opt.wrap = true

-- When we leave a markdown file
-- vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
--   pattern = { '*.md' },
--   callback = function()
--     vim.opt.colorcolumn:remove()
--     vim.opt.textwidth:remove()
--     vim.opt.wrap:remove()
--   end,
-- })
