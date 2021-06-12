---
-- LUA ROCKS THIS CONFIGURATION
-- LIKE A MOTHER-FUCKER
-- PERSONAL NVIM OF KORNICAMEISTER
---
local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options
local o, wo, bo = vim.o, vim.wo, vim.bo

local plugins = require('plugins')
local utils = require('utils')
local vimp = require('vimp')

local autocmd = utils.autocmd
local nnoremap = vimp.nnoremap

-- settings
local buffer = {o, bo}
local window = {o, wo}

g.mapleader = [[,]]
g.maplocalleader = [[,]]

opt.smartindent = true
opt.autoindent = true
opt.copyindent = true

opt.list = true
vim.cmd [[ set listchars-=nbsp:+ ]]
vim.cmd [[ set listchars-=trail- ]]
vim.cmd [[ set listchars+=trail:•,nbsp:~ ]]

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true

opt.wrap = false
opt.wrapscan = true
vim.cmd [[ set whichwrap+=<,>,[,] ]]

opt.number = true
opt.relativenumber = true
opt.ruler = true
autocmd('numbertoogle', [[BufEnter,FocusGained,InsertLeave * set relativenumber]])
autocmd('numbertoogle', [[BufLeave,FocusLost,InsertEnter   * set norelativenumber]])

opt.errorbells = false
opt.visualbell = false
opt.modelines = 0
opt.modeline = false
opt.title = true

opt.swapfile = false
opt.backup = false
opt.writebackup = false

cmd [[colorscheme wal]]
opt.termguicolors = false
opt.background = 'dark'
g.airline_theme = 'wal'

--- keybindings ---
local silent = {silent = true}

nnoremap(';', ':') --quicker access to command

-- window movement
nnoremap('<c-h>', '<c-w>h')
nnoremap('<c-j>', '<c-w>j')
nnoremap('<c-k>', '<c-w>k')
nnoremap('<c-l>', '<c-w>l')
-- window resize
nnoremap('<c-left>', [[:vertical resize +2<cr>]])
nnoremap('<c-right>', [[:vertical resize -2<cr>]])
nnoremap('<c-up>', [[:resize +2<cr>]])
nnoremap('<c-down>', [[:resize -2<cr>]])
