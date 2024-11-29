-- NOTE: Some keymaps are in ui.lua where some plugins are initialized.
-- I'm not sure how to get them into here instead.

-- Leader key mapping

vim.g.mapleader = ' '

vim.keymap.set('n', '<space>w', '<C-w>', { desc = 'Window mode' })

-- Pickers
vim.keymap.set('n', '<space>f', function()
  MiniPick.builtin.files({ tool = 'git' })
end, { desc = 'Find files' })
vim.keymap.set('n', '<space>F', function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = 'File explorer' })
vim.keymap.set('n', '<space>b', MiniPick.builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<space>/', MiniPick.builtin.grep_live, { desc = 'Find' })
vim.keymap.set('n', '<space>j', function()
  MiniExtra.pickers.list({ scope = "jump" })
end, { desc = 'Jumplist' })
vim.keymap.set('n', '<space>\'', MiniPick.builtin.resume, { desc = 'Resume last picker' })

-- Todo: set up MiniPick.builtin.resume

-- Copy to system clipboard
vim.keymap.set({ 'n', 'x' }, '<space>y', '"+y', { desc = 'Copy to system clipboard' })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = function(str)
      return { buffer = ev.buf, desc = str }
    end

    -- Pickers
    vim.keymap.set('n', 'gr', function()
      MiniExtra.pickers.lsp({ scope = "references" })
    end, opts("Buffer References"))

    vim.keymap.set('n', '<space>s', function()
      MiniExtra.pickers.lsp({ scope = "document_symbol" })
    end, opts("Symbols"))

    vim.keymap.set('n', '<space>D', MiniExtra.pickers.diagnostic, opts("Diagnostics"))

    vim.keymap.set('n', '<space>l', function()
      MiniExtra.pickers.lsp({ scope = "workspace_symbol" })
    end, opts("Workspace Symbols"))

    -- Actions
    vim.keymap.set('n', '<space>k', vim.lsp.buf.hover, opts("Hover"))
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts("Declaration"))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts("Definition"))
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts("References"))
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts("Implementation"))
    vim.keymap.set('n', '<M-k>', vim.lsp.buf.signature_help, opts("Signature Help"))
    vim.keymap.set('i', '<M-k>', vim.lsp.buf.signature_help, opts("Signature Help"))
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts("Type Definition"))
    vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, opts("Rename Symbol"))
    vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts("Code Action"))
    vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts("Line Diagnostic"))
  end,
})
