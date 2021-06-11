local g = vim.g;
local vimp = require('vimp');

g.committia_hooks = {}

-- Scroll the diff window from insert mode
-- Map <C-n> and <C-p>
vimp.imap({'buffer'}, '<C-n>', '<Plug>(committia-scroll-diff-down-half<Plug>')
vimp.imap({'buffer'}, '<C-p>', '<Plug>(committia-scroll-diff-up-half)')
