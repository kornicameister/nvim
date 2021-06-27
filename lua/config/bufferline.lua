require("bufferline").setup({
  options = {
    modified_icon = "✥",
    buffer_close_icon = "",
    numbers = "buffer_id",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or ""
      return " " .. icon .. " " .. count
    end,
    show_buffer_close_icons = false,
  },
})

local opts = {
  noremap = true,
  silent = true,
}

vim.api.nvim_set_keymap("n", "<Tab>", "<CMD>BufferLineCycleNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-Tab>", "<CMD>BufferLineCyclePrev<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>q", [[ :bd<cr>gT ]], opts)
vim.api.nvim_set_keymap("n", "<leader>Q", [[ :bufdo bd<CR> ]], opts)
vim.api.nvim_set_keymap("n", "<leader>r", [[ :e<CR> ]], opts)
vim.api.nvim_set_keymap("n", "<leader>R", [[ :e!<CR> ]], opts)
