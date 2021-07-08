require("bufferline").setup({
  options = {
    separator_style = "slant",
    modified_icon = "✥",
    buffer_close_icon = "",
    numbers = "buffer_id",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, _, context)
      if context.buffer:current() then
        return ""
      end
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

require("which-key").register({
  ["<Tab>"] = { "<cmd>BufferLineCycleNext<CR>", "bufferline: next" },
  ["<S-Tab>"] = { "<cmd>BufferLineCyclePrev<CR>", "bufferline: prev" },
  ["<leader>B"] = { "<cmd>BufferLinePick<CR>", "bufferline: pick" },
}, opts)

vim.api.nvim_set_keymap("n", "<leader>q", [[ :bd<cr>gT ]], opts)
vim.api.nvim_set_keymap("n", "<leader>Q", [[ :bufdo bd<CR> ]], opts)
vim.api.nvim_set_keymap("n", "<leader>r", [[ :e<CR> ]], opts)
vim.api.nvim_set_keymap("n", "<leader>R", [[ :e!<CR> ]], opts)
