-- Ensure mini.nvim is installed and up to date
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    -- Uncomment next line to use 'stable' branch
    -- '--branch', 'stable',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Setup
require("mini.deps").setup()
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- now
now(function() require("core/ui") end)
now(function() require("mini.basics").setup() end)
now(function() require("mini.pick").setup() end)
now(function() require("mini.statusline").setup() end)
now(function() require("core/theme") end)
now(function() require("core/keymap") end)

add({
  source = 'folke/snacks.nvim',
  opts = {
    git = { enabled = "true" }
  }
})

now(function()
  -- this one is a PR with a performance fix for fish
  add({ source = 'srithon/nvim-tmux-navigation' })
  local vim_tmux_nav = require('nvim-tmux-navigation')

  vim_tmux_nav.setup({
    -- disable_when_zoomed = true, -- defaults to false

    -- for the nvim version
    keybindings = {
      left = "<C-h>",
      down = "<C-j>",
      up = "<C-k>",
      right = "<C-l>",
      last_active = "<C-\\>",
      next = "<C-Space>",
    }
  })
end)

--later
later(function()
  require("mini.comment").setup({
    mappings = {
      comment = '<space>c',
      comment_line = '<space>C',
      comment_visual = '<space>c',
      text_object = '<space>c',
    }
  })
end)
later(function() require("mini.diff").setup() end)
later(function() require("mini.extra").setup() end)
later(function()
  require("mini.files").setup({
    mappings = {
      synchronize = "-" -- default "="
    },
    options = {
      use_as_default_explorer = false
    }
  })
end)
later(function() require("mini.git").setup() end)
later(function() require("mini.pairs").setup() end)
later(function() require("mini.notify").setup() end)
later(function() require("mini.trailspace").setup() end)
later(function() require("core/clue") end)
later(function() require("core/lsp") end)
later(function() require("core/auto_format_on_save") end)
later(function() require("extra/zk") end)

-- At launch
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function() 
    if vim.fn.argv(0) == "." then
      MiniPick.builtin.files({ tool = 'git' })
    end
  end
})
