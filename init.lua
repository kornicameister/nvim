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

-- settings
local buffer = {o, bo}
local window = {o, wo}

g.mapleader = [[,]]
g.maplocalleader = [[,]]

opt.hidden = true                             -- keep buffers around, hide them but close them

opt.splitbelow = true
opt.splitright = true
vimp.nnoremap('<c-h>', '<c-w>h')
vimp.nnoremap('<c-j>', '<c-w>j')
vimp.nnoremap('<c-k>', '<c-w>k')
vimp.nnoremap('<c-l>', '<c-w>l')
vimp.nnoremap({'silent'}, '<c-left>', [[:vertical resize +2<cr>]])
vimp.nnoremap({'silent'}, '<c-right>', [[:vertical resize -2<cr>]])
vimp.nnoremap({'silent'}, '<c-up>', [[:resize +2<cr>]])
vimp.nnoremap({'silent'}, '<c-down>', [[:resize -2<cr>]])

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

opt.belloff = 'all'     -- turn the bell off!
opt.modelines = 0       -- do not execute mode line
opt.modeline = false    --
opt.title = true        -- show title, why not

opt.inccommand = 'split'
opt.swapfile = false
opt.backup = false
opt.writebackup = false

opt.history = 10000
opt.undolevels = 10000
opt.undoreload = 10000
opt.undodir = fn.stdpath('config') .. '/undodir'
opt.undofile = true

opt.clipboard = 'unnamedplus'

opt.spell = false
vimp.nmap({'silent', 'buffer'}, '<leader>ss', [[:setlocal spell!<cr>]])

opt.foldmethod = 'marker'
opt.foldlevel = 0
vimp.nnoremap({'silent'}, '<Space>' , 'za')
vimp.vnoremap({'silent'}, '<Space>' , 'za')

vimp.nnoremap(';', ':')                       -- quicker access to :cmd

vimp.nnoremap({ 'silent' }, '<Tab>', [[ :bnext<CR> ]])       -- buffer navigations
vimp.nnoremap({ 'silent' }, '<S-Tab>', [[ :bprevious<CR> ]])
vimp.nnoremap({ 'silent' }, '<leader>q', [[ :bd<cr>gT ]])
vimp.nnoremap({ 'silent' }, '<leader>Q', [[ :bufdo bd<CR> ]])
vimp.nnoremap({ 'silent' }, '<leader>r', [[ :e<CR> ]])
vimp.nnoremap({ 'silent' }, '<leader>R', [[ :e!<CR> ]])

cmd [[colorscheme wal]]
opt.termguicolors = false
opt.background = 'dark'
g.airline_theme = 'wal'
