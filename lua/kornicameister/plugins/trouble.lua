local opts = {
  silent = true,
  noremap = true,
}
vim.api.nvim_set_keymap('n', '<leader>xx', '<cmd>TroubleToggle<cr>', opts)

require('trouble').setup({
  position = 'right',
  auto_preview = false,
  auto_fold = true,
})
