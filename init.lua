---
-- LUA ROCKS THIS CONFIGURATION
-- LIKE A MOTHER-FUCKER
-- PERSONAL NVIM OF KORNICAMEISTER
---
local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local env = vim.env --access to env
local opt = vim.opt -- to set options
local o, wo, bo = vim.o, vim.wo, vim.bo

local plugins = require("plugins")
local utils = require("utils")
local vimp = require("vimp")

local autocmd = utils.autocmd

-- settings
local buffer = { o, bo }
local window = { o, wo }

g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.python2_host_prog = env.PYENV_ROOT .. "/versions/neovim2/bin/python"
g.python3_host_prog = env.PYENV_ROOT .. "/versions/neovim3/bin/python"

g.mapleader = [[,]]
g.maplocalleader = [[,]]

opt.shell = "/bin/zsh"

opt.hidden = true -- keep buffers around, hide them but close them

opt.splitbelow = true
opt.splitright = true
vimp.nnoremap("<c-h>", "<c-w>h")
vimp.nnoremap("<c-j>", "<c-w>j")
vimp.nnoremap("<c-k>", "<c-w>k")
vimp.nnoremap("<c-l>", "<c-w>l")
vimp.nnoremap({ "silent" }, "<c-left>", [[:vertical resize +2<cr>]])
vimp.nnoremap({ "silent" }, "<c-right>", [[:vertical resize -2<cr>]])
vimp.nnoremap({ "silent" }, "<c-up>", [[:resize +2<cr>]])
vimp.nnoremap({ "silent" }, "<c-down>", [[:resize -2<cr>]])

opt.smartindent = true
opt.autoindent = true
opt.copyindent = true

opt.list = true
vim.cmd([[ set listchars-=nbsp:+ ]])
vim.cmd([[ set listchars-=trail- ]])
vim.cmd([[ set listchars+=trail:•,nbsp:~ ]])
vim.cmd([[ highlight BadWhitespace ctermbg=red guibg=red ]])

autocmd('trimwhitespaces', [[BufWritePre * :%s/\s\+$//e ]])

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true

opt.breakindent = true
opt.breakindentopt = "shift:2"
opt.showbreak = "↳"

opt.joinspaces = true

opt.wrap = false
opt.wrapscan = true
vim.cmd([[ set whichwrap+=<,>,[,] ]])

opt.number = true
opt.relativenumber = true
opt.ruler = true
autocmd("numbertoogle", [[BufEnter,FocusGained,InsertLeave * set relativenumber]])
autocmd("numbertoogle", [[BufLeave,FocusLost,InsertEnter   * set norelativenumber]])

opt.belloff = "all" -- turn the bell off!
opt.modelines = 0 -- do not execute mode line
opt.modeline = false --
opt.title = true -- show title, why not

opt.inccommand = "split" -- incremental live completion
opt.swapfile = false
opt.backup = false
opt.writebackup = false

opt.history = 10000
opt.undolevels = 10000
opt.undoreload = 10000
opt.undodir = fn.stdpath("config") .. "/undodir"
opt.undofile = true
opt.autoread = true
opt.autowrite = true
autocmd("autosave", [[FocusLost * :wa]])

opt.hlsearch = true -- highlight on search
opt.incsearch = true

opt.clipboard = "unnamedplus"

opt.spell = false
vimp.nmap({ "silent", "buffer" }, "<leader>ss", [[:setlocal spell!<cr>]])

opt.foldmethod = "indent"
opt.foldlevel = 99
vimp.nnoremap({ "silent" }, "<Space>", "za")
vimp.vnoremap({ "silent" }, "<Space>", "za")

vimp.nnoremap(";", ":") -- quicker access to :cmd

opt.wildmenu = true
opt.wildmode = { "longest:full", "full" }
opt.wildoptions = "pum"
opt.wildignore = {
  -- general
  "/tmp/**",
  -- git
  "*/.git/**",
  -- windows
  "*.ppt",
  "*.pptx",
  "*.doc",
  "*.docx",
  "*.xlt",
  "*.xls",
  "*.xlsx",
  "*.odt",
  "*.wps",
  "*.dll",
  "*.exe",
  -- aws
  "*/.aws-sam/*",
  -- python
  "*.pyc",
  "*.pyo",
  "*.egg",
  "__pycache__",
  "*/.venv/*",
  -- web dev
  "*/node_modules/*",
  "*/elm-stuff/*",
}

opt.viewoptions:remove("options")
opt.viewoptions:append({ "slash", "unix" })

-- vertical help
vim.api.nvim_exec(
  [[
  augroup help_vertical
    au!
    command! -nargs=* -complete=help Help vertical belowright help <args>
    autocmd FileType help wincmd L
  augroup end
  ]],
  false
)

-- ESC leaves terminal mode
vim.api.nvim_exec(
  [[
  augroup Terminal
    autocmd!
    au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
    au TermOpen * set nonu
  augroup end
  ]],
  false
)

-- Highlight on yank
-- Y does yy till the end of the line
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
  ]],
  false
)
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })

-- keep cursos in place when joining lines
vim.api.nvim_set_keymap("n", "J", "mzJ`z", { noremap = true })

-- copy to cliboard in n,v,s,o modes
vim.api.nvim_set_keymap("", "<C-c>", '"+y', { noremap = true })
