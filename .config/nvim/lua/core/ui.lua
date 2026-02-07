local add = MiniDeps.add

-- Treesitter
add({ source = 'nvim-treesitter/nvim-treesitter' })
require("nvim-treesitter").setup({ build = ":TSUpdate" })
require('nvim-treesitter.configs').setup {
  ensure_installed = { "elixir", "eex", "heex", "terraform", "helm", "typescript" },
  highlight = {
    additional_vim_regex_highlighting = false,
    enable = true,
  },

  indent = { enable = true },

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
}

-- Soft tabs, 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
