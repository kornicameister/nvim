local g, opt = vim.g, vim.opt

opt.termguicolors = true
opt.background = "dark"

g.material_style = "deep ocean"
g.material_disable_background = true
g.material_italic_comments = false

require("material").set()
