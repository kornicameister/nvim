local map = vim.keymap.set

-- navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Window: left' })
map('n', '<C-j>', '<C-w>j', { desc = 'Window: down' })
map('n', '<C-k>', '<C-w>k', { desc = 'Window: up' })
map('n', '<C-l>', '<C-w>l', { desc = 'Window: right' })

-- resize
map('n', '<C-S-Left>', ':vertical resize +2<cr>', { silent = true, desc = 'Window: wider' })
map('n', '<C-S-Right>', ':vertical resize -2<cr>', { silent = true, desc = 'Window: narrower' })
map('n', '<C-S-Up>', ':resize +2<cr>', { silent = true, desc = 'Window: taller' })
map('n', '<C-S-Down>', ':resize -2<cr>', { silent = true, desc = 'Window: shorter' })
