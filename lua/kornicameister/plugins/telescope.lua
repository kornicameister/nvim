local telescope = require("telescope")

telescope.load_extension("lsp_handlers")
telescope.setup({
  vimgrep_arguments = {
    "ag",
    "--nogroup",
    "--nocolor",
    "--vimgrep",
  },
  extensions = {
    lsp_handlers = {
      code_action = {
        telescope = require("telescope.themes").get_dropdown({}),
      },
    },
  },
})

local opts = {}
require("which-key").register({
  ["ff"] = {
    "<cmd>lua require('telescope.builtin').find_files()<cr>",
    "Files: Git",
  },
  ["fg"] = {
    "<cmd>lua require('telescope.builtin').git_files()<cr>",
    "Files: Git",
  },
  ["sg"] = {
    "<cmd>lua require('telescope.builtin').live_grep()<cr>",
    "Searching: Grep",
  },
}, {
  prefix = "<leader>",
  noremap = true,
  silent = true,
})
