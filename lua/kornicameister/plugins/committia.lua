local g = vim.g
local vimp = require("vimp")

g.committia_hooks = {}

-- Scroll the diff window from insert mode
-- Map <A-n> and <A-p>
vimp.imap({ "buffer" }, "<A-n>", "<Plug>(committia-scroll-diff-down-half")
vimp.imap({ "buffer" }, "<A-p>", "<Plug>(committia-scroll-diff-up-half)")
