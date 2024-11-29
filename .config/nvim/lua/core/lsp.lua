-- From https://lsp-zero.netlify.app/docs/getting-started.html

-- LSPs
MiniDeps.add({source = 'VonHeikemen/lsp-zero.nvim', checkout = 'v4.x'})
MiniDeps.add({source = 'neovim/nvim-lspconfig'})
MiniDeps.add({
  source = 'hrsh7th/nvim-cmp',
  depends = {
    'hrsh7th/cmp-nvim-lsp',
  },
})

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- Disable virtual text
vim.diagnostic.config({
  virtual_text = false,
})

-- Languages

local lspconfig = require('lspconfig')

lspconfig.elixirls.setup({
  cmd = { "/opt/homebrew/bin/elixir-ls" }
})
lspconfig.ts_ls.setup{}
lspconfig.ruby_lsp.setup{}

-- Helm/Terraform
-- MiniDeps.add({ source = 'towolf/vim-helm' })
-- lspconfig.yamlls.setup({})
-- lspconfig.helm_ls.setup({
--   -- ['helm-ls'] = {
--   --   yamlls = {
--   --     path = 'yaml-language-server'
--   --   }
--   -- }
-- })
lspconfig.terraformls.setup({})
