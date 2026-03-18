---
-- LUA ROCKS THIS CONFIGURATION
-- LIKE A MOTHER-FUCKER
-- PERSONAL NVIM OF KORNICAMEISTER
---
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local opt = vim.opt -- to set options

require('config')
require('integrations')
require('plugins')

-- settings

opt.splitbelow = true
opt.splitright = true

opt.smartindent = true
opt.autoindent = true
opt.copyindent = true

opt.list = true
vim.cmd([[ set listchars-=nbsp:+ ]])
vim.cmd([[ set listchars-=trail- ]])
vim.cmd([[ set listchars+=trail:•,nbsp:~ ]])
vim.cmd([[ highlight BadWhitespace ctermbg=red guibg=red ]])

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true

opt.breakindent = true
opt.breakindentopt = 'shift:2'
opt.showbreak = '↳'

opt.joinspaces = true

opt.wrap = false
opt.wrapscan = true
vim.cmd([[ set whichwrap+=<,>,[,] ]])

opt.number = true
opt.relativenumber = true
opt.ruler = true

opt.belloff = 'all' -- turn the bell off!
opt.modelines = 0 -- do not execute mode line
opt.modeline = false --
opt.title = true -- show title, why not

opt.inccommand = 'split' -- incremental live completion
opt.swapfile = false
opt.backup = false
opt.writebackup = false

opt.history = 10000
opt.undolevels = 10000
opt.undoreload = 10000
opt.undodir = fn.stdpath('config') .. '/undodir'
opt.undofile = true
opt.autoread = true
opt.autowrite = true

opt.autochdir = false

opt.hlsearch = true -- highlight on search
opt.incsearch = true

opt.clipboard = 'unnamedplus'

opt.wildmenu = true
opt.wildmode = { 'longest:full', 'full' }
opt.wildoptions = 'pum'
opt.wildignore = {
  -- general
  '/tmp/**',
  -- git
  '*/.git/**',
  -- windows
  '*.ppt',
  '*.pptx',
  '*.doc',
  '*.docx',
  '*.xlt',
  '*.xls',
  '*.xlsx',
  '*.odt',
  '*.wps',
  '*.dll',
  '*.exe',
  -- aws
  '*/.aws-sam/*',
  -- python
  '*.pyc',
  '*.pyo',
  '*.egg',
  '__pycache__',
  '*/.venv/*',
  -- web dev
  '*/node_modules/*',
  '*/elm-stuff/*',
}

opt.viewoptions:remove('options')
opt.viewoptions:append({ 'slash', 'unix' })

vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- keep cursos in place when joining lines
vim.api.nvim_set_keymap('n', 'J', 'mzJ`z', { noremap = true })

-- copy to cliboard in n,v,s,o modes
vim.api.nvim_set_keymap('', '<C-c>', '"+y', { noremap = true })
