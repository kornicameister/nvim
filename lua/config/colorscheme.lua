local g, opt = vim.g, vim.opt

opt.termguicolors = true
opt.background = "dark"

g.tokyodark_transparent_background = true
g.tokyodark_enable_italic_comment = true
g.tokyodark_enable_italic = true
vim.cmd[[colorscheme tokyodark]]

