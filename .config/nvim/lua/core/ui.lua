local add = MiniDeps.add

-- Treesitter
add({ source = 'nvim-treesitter/nvim-treesitter' })
require("nvim-treesitter").setup({ build = ":TSUpdate" })
require('nvim-treesitter.configs').setup {
  ensure_installed = { "elixir", "eex", "heex" },
  highlight = {
    additional_vim_regex_highlighting = false,
    enable = true,
  },
  indent = { enable = true },
}

-- Soft tabs, 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
