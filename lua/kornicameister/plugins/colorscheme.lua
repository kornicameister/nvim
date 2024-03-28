local g, opt = vim.g, vim.opt

opt.termguicolors = true
opt.background = 'dark'

require('nightfox').setup({
  options = {
    terminal_colors = true,
    dim_inactive = true,
  },
})

vim.cmd([[colorscheme duskfox]])
