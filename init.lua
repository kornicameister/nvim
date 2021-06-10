---
-- LUA ROCKS THIS CONFIGURATION
-- LIKE A MOTHER-FUCKER
-- PERSONAL NVIM OF KORNICAMEISTER
---

local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local plugins = require('plugins')
local utils = require('utils')
local vimp = require('vimp')

local opt = utils.opt
local autocmd = utils.autocmd
local nnoremap = vimp.nnoremap

-- editor setup
cmd [[colorscheme wal]]

--- keybindings ---
local silent = {silent = true}
-- window movement
nnoremap('<c-h>', '<c-w>h')
nnoremap('<c-j>', '<c-w>j')
nnoremap('<c-k>', '<c-w>k')
nnoremap('<c-l>', '<c-w>l')
-- window resize
nnoremap('<c-left>',  [[:vertical resize +2<cr>]] )
nnoremap('<c-right>', [[:vertical resize -2<cr>]] )
nnoremap('<c-up>',    [[:resize +2<cr>]] )
nnoremap('<c-down>',  [[:resize -2<cr>]] )
