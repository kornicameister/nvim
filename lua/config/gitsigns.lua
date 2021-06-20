local has_buddy, _ = pcall(require, "colorbuddy")
if has_buddy then
  local c = require("colorbuddy.color").colors
  local Group = require("colorbuddy.group").Group

  Group.new("GitSignsAdd", c.green)
  Group.new("GitSignsChange", c.yellow)
  Group.new("GitSignsDelete", c.red)
end

require("gitsigns").setup({
  numhl = true,
  linehl = false,
  signs = {
    add = { hl = "GitSignsAdd", text = "", numhl = "GitSignsAddNr" },
    delete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr" },
    change = { hl = "GitSignsChange", text = "", numhl = "GitSignsChangeNr" },
    changedelete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsChangeNr" },
    topdelete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr" },
  },
  keymaps = {
    -- defaults
    noremap = true,
    buffer = true,

    -- navigate hunks
    ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
    ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },

    ["n <A-,"] = { noremap = false, silent = true, "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>" },
    ["n <A-.>"] = { noremap = false, silent = true, "<cmd>lua require('gitsigns').stage_hunk()<CR>" },
    ["n <A-/>"] = { noremap = false, silent = true, "<cmd>lua require('gitsigns').preview_hunk()<CR>" },
  },
})
