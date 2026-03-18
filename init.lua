---
-- LUA ROCKS THIS CONFIGURATION
-- LIKE A MOTHER-FUCKER
-- PERSONAL NVIM OF KORNICAMEISTER
---

require('config')
require('integrations')
require('plugins')

vim.keymap.set('n', 'Y', 'y$', { desc = 'Yank to end of line' })

-- keep cursor in place when joining lines
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines (keep cursor)' })

-- copy to clipboard in n,v,s,o modes
vim.keymap.set('', '<C-c>', '"+y', { desc = 'Copy to clipboard' })
