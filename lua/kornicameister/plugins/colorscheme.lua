vim.opt.termguicolors = true
vim.opt.background = 'dark'

require('nightfox').setup({
  options = {
    terminal_colors = true,
    dim_inactive = true,
  },
})

vim.cmd([[colorscheme nordfox]])
