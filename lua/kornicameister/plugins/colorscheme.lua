local g, opt = vim.g, vim.opt

opt.termguicolors = true
opt.background = "dark"

g.material_style = "darker"

require("material").setup({
  popup_menu = "dark",
  text_contrast = { darker = true },
  contrast_widonws = { "packer", "fzf", "terminal" },
})

require("which-key").register({
  ["<leader>mm"] = {
    "<cmd>lua require('material.functions').toggle_style()<CR>",
    "Toogle scheme",
  },
}, {
  noremap = true,
  silent = true,
})

vim.cmd([[colorscheme material]])
