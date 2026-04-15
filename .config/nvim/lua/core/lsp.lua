-- Completion
MiniDeps.add({ source = "saghen/blink.cmp", checkout = "v0.13.0" })

-- Reserve gutter space
vim.opt.signcolumn = 'yes'

-- Disable virtual text
vim.diagnostic.config({ virtual_text = false })

-- blink.cmp setup
require('blink.cmp').setup({
  completion = {
    menu = { auto_show = function(ctx) return ctx.mode ~= 'cmdline' end }
  },
  keymap = { preset = 'enter' },
  signature = { enabled = true },
  sources = {
    default = { 'lsp', 'path', 'snippets' },
  },
})

-- Inject blink.cmp capabilities into all LSP clients
vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

-- LSP server configs
vim.lsp.config('elixirls', {
  cmd = { '/opt/homebrew/bin/elixir-ls' },
  filetypes = { 'elixir', 'eex', 'heex' },
  root_markers = { 'mix.exs', '.git' },
})

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
  root_markers = { 'tsconfig.json', 'package.json', '.git' },
})

vim.lsp.config('ruby_lsp', {
  cmd = { 'ruby-lsp' },
  filetypes = { 'ruby' },
  root_markers = { 'Gemfile', '.git' },
})

vim.lsp.config('eslint', {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' },
  root_markers = { '.eslintrc', '.eslintrc.js', '.eslintrc.json', 'eslint.config.js', 'eslint.config.mjs', 'package.json' },
})

vim.lsp.config('terraformls', {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform' },
  root_markers = { '.terraform', '.git' },
})

vim.lsp.enable({ 'elixirls', 'ts_ls', 'ruby_lsp', 'eslint', 'terraformls' })

-- Auto-fix eslint on save
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.name == 'eslint' then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.code_action({
            context = { only = { 'source.fixAll.eslint' } },
            apply = true,
          })
        end,
      })
    end
  end,
})
