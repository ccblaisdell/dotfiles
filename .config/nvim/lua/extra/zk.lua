MiniDeps.add({ source = "zk-org/zk-nvim" })

require("zk").setup({
  -- Can be "telescope", "fzf", "fzf_lua", "minipick", "snacks_picker",
  -- or select" (`vim.ui.select`). It's recommended to use "telescope",
  -- "fzf", "fzf_lua", "minipick", or "snacks_picker".
  picker = "minipick",

  -- lsp = {
  --   -- `config` is passed to `vim.lsp.start_client(config)`
  --   config = {
  --     cmd = { "zk", "lsp" },
  --     name = "zk",
  --     -- on_attach = ...
  --     -- etc, see `:h vim.lsp.start_client()`
  --   },
  --
  --   -- automatically attach buffers in a zk notebook that match the given filetypes
  --   auto_attach = {
  --     enabled = true,
  --     filetypes = { "markdown" },
  --   },
  -- },
})

-- Normal mode

-- Create a new note after asking for its title.
vim.api.nvim_set_keymap("n", "<leader>vn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", { desc = 'New Note' })

-- Pickers
vim.api.nvim_set_keymap("n", "<leader>vf", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", { desc = 'Open Note' })
vim.api.nvim_set_keymap("n", "<leader>vt", "<Cmd>ZkTags<CR>", { desc = 'Open Note with tags' })

-- Open specific files
vim.keymap.set('n', '<leader>vj', "<Cmd>ZkNew { dir = 'journal' }<CR>", { desc = 'Open Journal', noremap = true, silent = true })
vim.keymap.set('n', '<leader>vw', function() vim.cmd('edit ~/dev/cyborg-brain/todo-work.md') end, { desc = 'Open Work Todos', noremap = true, silent = true })

-- Search
vim.api.nvim_set_keymap("n", "<leader>v/", "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", { desc = 'Search Notes' })

-- Create a new note with the with word under cursor as title
-- vim.api.nvim_set_keymap("n", "<leader>dd", function()
--   local word = vim.fn.expand("<cword>")
--   require("zk.commands").get("ZkNew")({ title = word })
-- end, { desc = 'New Note with Title' })

-- Create a new note with the current word as title
vim.api.nvim_set_keymap("n", "<leader>vd", ":'<,'>ZkNewFromTitleSelection<CR>", { desc = 'New Note with Selection' })
vim.keymap.set('n', '<leader>vd', function()
  local word = vim.fn.expand('<cword>')
  vim.cmd('ZkNew { title = "' .. word .. '" }')
end, { desc = 'New note with title' })

-- Visual mode

-- Create a new note with the current visual selection as title
vim.api.nvim_set_keymap("v", "<leader>vd", ":'<,'>ZkNewFromTitleSelection<CR>", { desc = 'New Note with Selection' })

-- Search for the notes matching the current visual selection.
vim.api.nvim_set_keymap("v", "<leader>v/", ":'<,'>ZkMatch<CR>", { desc = 'Search Notes with Selection' })
