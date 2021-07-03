local opts = { silent = true , noremap = true}

vim.api.nvim_set_keymap("n", "<leader>t", ":Tags<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>bt", ":BTags<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>f", ":GFiles<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>F", ":Files<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>c", ":Commits<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>b", ":Buffers<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>h", ":History<CR>", opts)

vim.g.fzf_layout = {
  window = {
    width = 0.9,
    height = 0.6,
  },
}
