local g, opt = vim.g, vim.opt

opt.termguicolors = true
opt.background = "dark"

g.calvera_style = "deep ocean"
g.calvera_disable_background = true
g.calvera_italic_comments = false

require("calvera").set()
