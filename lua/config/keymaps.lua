local map = vim.keymap.set

-- navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Window: left' })
map('n', '<C-j>', '<C-w>j', { desc = 'Window: down' })
map('n', '<C-k>', '<C-w>k', { desc = 'Window: up' })
map('n', '<C-l>', '<C-w>l', { desc = 'Window: right' })

-- resize
map(
  'n',
  '<C-S-Left>',
  ':vertical resize +2<cr>',
  { silent = true, desc = 'Window: wider' }
)
map(
  'n',
  '<C-S-Right>',
  ':vertical resize -2<cr>',
  { silent = true, desc = 'Window: narrower' }
)
map(
  'n',
  '<C-S-Up>',
  ':resize +2<cr>',
  { silent = true, desc = 'Window: taller' }
)
map(
  'n',
  '<C-S-Down>',
  ':resize -2<cr>',
  { silent = true, desc = 'Window: shorter' }
)

-- editing
map('n', 'Y', 'y$', { desc = 'Yank to end of line' })
map('n', 'J', 'mzJ`z', { desc = 'Join lines (keep cursor)' })
map('', '<C-c>', '"+y', { desc = 'Copy to clipboard' })

-- commenting
map('n', '<leader>cc', function()
  vim.api.nvim_feedkeys('gcc', 'm', false)
end, { desc = 'Comment: toggle line' })
map('v', '<leader>cc', function()
  vim.api.nvim_feedkeys('gc', 'm', false)
end, { desc = 'Comment: toggle selection' })
