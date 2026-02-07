-- From https://lsp-zero.netlify.app/docs/getting-started.html
--

-- LSPs
MiniDeps.add({source = 'VonHeikemen/lsp-zero.nvim', checkout = 'v4.x'})
MiniDeps.add({source = 'neovim/nvim-lspconfig'})
MiniDeps.add({ source = "saghen/blink.cmp", checkout = "v0.13.0" })

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- Disable virtual text
vim.diagnostic.config({
  virtual_text = false,
})

-- Languages
--
-- Add blink.cmp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('blink.cmp').get_lsp_capabilities()
)
require('blink.cmp').setup({
  -- Don't show completion menu automatically in cmdline mode
  completion = { 
    menu = { auto_show = function(ctx) return ctx.mode ~= 'cmdline' end }
  },
  keymap = { preset = 'enter' },
  signature = { enabled = true },
  sources = {
    default = { 'lsp', 'path', 'snippets' }, -- 'buffer'
  },
})

local lspconfig = require('lspconfig')

lspconfig.elixirls.setup({
  cmd = { "/opt/homebrew/bin/elixir-ls" }
})
lspconfig.ts_ls.setup({
  single_file_support = true
})
lspconfig.ruby_lsp.setup({})
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#eslint
lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

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
