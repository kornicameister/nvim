require("bufferline").setup({
  options = {
    modified_icon = "✥",
    buffer_close_icon = "",
    numbers = "buffer_id",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
      local icon = level:match('error') and ' ' or ''
      return ' ' .. icon .. ' ' .. count
    end,
    show_buffer_close_icons = false,
  },
})
