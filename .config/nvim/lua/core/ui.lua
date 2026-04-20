-- Treesitter
require('nvim-treesitter').setup({
  ensure_installed = { "elixir", "eex", "heex", "terraform", "helm", "typescript" },
})

-- Treesitter highlighting (built into Neovim, just needs enabling)
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- Soft tabs, 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
