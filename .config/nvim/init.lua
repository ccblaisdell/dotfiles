-- Bootstrap plugins into vim.pack (pack/plugins/start)
local plugins = {
  { name = 'mini.nvim', url = 'https://github.com/echasnovski/mini.nvim' },
  { name = 'snacks.nvim', url = 'https://github.com/folke/snacks.nvim' },
  { name = 'nvim-treesitter', url = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { name = 'blink.cmp', url = 'https://github.com/saghen/blink.cmp', tag = 'v0.13.0' },
  { name = 'poimandres.nvim', url = 'https://github.com/olivercederborg/poimandres.nvim' },
  { name = 'catppuccin', url = 'https://github.com/catppuccin/nvim' },
  { name = 'zk-nvim', url = 'https://github.com/zk-org/zk-nvim' },
}

local pack_path = vim.fn.stdpath('data') .. '/site/pack/plugins/start'
local any_installed = false
for _, plugin in ipairs(plugins) do
  local install_path = pack_path .. '/' .. plugin.name
  if not vim.uv.fs_stat(install_path) then
    any_installed = true
    vim.cmd('echo "Installing ' .. plugin.name .. '" | redraw')
    local cmd = { 'git', 'clone', '--filter=blob:none' }
    if plugin.tag then
      table.insert(cmd, '--branch')
      table.insert(cmd, plugin.tag)
    end
    table.insert(cmd, plugin.url)
    table.insert(cmd, install_path)
    vim.fn.system(cmd)
  end
end
if any_installed then
  vim.cmd('packloadall | helptags ALL')
end

-- Eager setup
require("core/ui")
require("mini.basics").setup()
require("mini.pick").setup()
require("mini.statusline").setup()
require("core/theme")
require("core/keymap")

-- Deferred setup
vim.schedule(function()
  require("mini.comment").setup({
    mappings = {
      comment = '<space>c',
      comment_line = '<space>C',
      comment_visual = '<space>c',
      text_object = '<space>c',
    }
  })
  require("mini.diff").setup()
  require("mini.extra").setup()
  require("mini.files").setup({
    mappings = {
      synchronize = "-" -- default "="
    },
    options = {
      use_as_default_explorer = false
    }
  })
  require("mini.git").setup()
  require("mini.pairs").setup()
  require("mini.notify").setup()
  require("mini.trailspace").setup()
  require("core/clue")
  require("core/lsp")
  require("core/auto_format_on_save")
  require("extra/zk")
end)

-- Load work-specific config if it exists
local work_config = vim.fn.expand("~/.work/init-work.lua")
if vim.fn.filereadable(work_config) == 1 then
  dofile(work_config)
end

-- At launch
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function() 
    if vim.fn.argv(0) == "." then
      MiniPick.builtin.files({ tool = 'git' })
    end
  end
})
