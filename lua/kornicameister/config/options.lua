local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options

g.mapleader = [[,]]
g.maplocalleader = [[,]]

opt.shell = '/usr/local/bin/fish'
opt.termguicolors = true

opt.hidden = true -- keep buffers around, hide them but close them
