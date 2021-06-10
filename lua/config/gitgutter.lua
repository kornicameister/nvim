local g = vim.g;
local vimp = require('vimp')

-- ignore whitespace changes
g.gitgutter_diff_args = '-w'

g.gitgutter_sign_added = ''
g.gitgutter_sign_modified = ''
g.gitgutter_sign_modified_removed = ''
g.gitgutter_sign_removed = ''
g.gitgutter_sign_removed_first_line = ''

g.gitgutter_highlight_linenrs = 1

vimp.nmap('<A-,>', '<Plug>(GitGutterUndoHunk)')
vimp.nmap('<A-.>', '<Plug>(GitGutterStageHunk)')
vimp.nmap('<A-/>', '<Plug>(GitGutterPreviewHunk)')
