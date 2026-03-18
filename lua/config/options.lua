local fn = vim.fn
local g = vim.g
local opt = vim.opt

g.mapleader = [[,]]
g.maplocalleader = [[,]]

opt.shell = '/usr/local/bin/fish'
opt.termguicolors = true
opt.hidden = true -- keep buffers around, hide them but close them

-- splits
opt.splitbelow = true
opt.splitright = true

-- indent
opt.smartindent = true
opt.autoindent = true
opt.copyindent = true

-- whitespace
opt.list = true
vim.cmd([[ set listchars-=nbsp:+ ]])
vim.cmd([[ set listchars-=trail- ]])
vim.cmd([[ set listchars+=trail:•,nbsp:~ ]])
vim.cmd([[ highlight BadWhitespace ctermbg=red guibg=red ]])

-- tabs
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true

-- wrap
opt.breakindent = true
opt.breakindentopt = 'shift:2'
opt.showbreak = '↳'
opt.joinspaces = true
opt.wrap = false
opt.wrapscan = true
vim.cmd([[ set whichwrap+=<,>,[,] ]])

-- line numbers
opt.number = true
opt.relativenumber = true
opt.ruler = true

-- misc
opt.belloff = 'all'
opt.modelines = 0
opt.modeline = false
opt.title = true

-- editing
opt.inccommand = 'split'
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- history / undo
opt.history = 10000
opt.undolevels = 10000
opt.undoreload = 10000
opt.undodir = fn.stdpath('config') .. '/undodir'
opt.undofile = true
opt.autoread = true
opt.autowrite = true
opt.autochdir = false

-- search
opt.hlsearch = true
opt.incsearch = true

-- clipboard
opt.clipboard = 'unnamedplus'

-- wildmenu
opt.wildmenu = true
opt.wildmode = { 'longest:full', 'full' }
opt.wildoptions = 'pum'
opt.wildignore = {
  '/tmp/**',
  '*/.git/**',
  '*.ppt', '*.pptx', '*.doc', '*.docx', '*.xlt', '*.xls', '*.xlsx', '*.odt', '*.wps', '*.dll', '*.exe',
  '*/.aws-sam/*',
  '*.pyc', '*.pyo', '*.egg', '__pycache__', '*/.venv/*',
  '*/node_modules/*', '*/elm-stuff/*',
}

-- view
opt.viewoptions:remove('options')
opt.viewoptions:append({ 'slash', 'unix' })
