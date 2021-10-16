local g, opt = vim.g, vim.opt

opt.termguicolors = true
opt.background = "dark"

g.tokyonight_style = "night"
g.tokyonight_italic_functions = true
g.tokyonight_sidebars = { "terminal", "packer" }
vim.cmd[[colorscheme tokyonight]]

