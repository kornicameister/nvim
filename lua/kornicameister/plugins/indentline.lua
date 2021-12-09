local g = vim.g

g.indent_blankline_char = "┊"
g.indent_blankline_use_treesitter = true
g.indent_blankline_filetype_exclude = {
  "tex",
  "markdown",
  "txt",
  "startify",
  "packer",
  "fzf",
  "help",
}
g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
g.indent_blankline_show_first_indent_level = false
g.indent_blankline_show_trailing_blankline_indent = false
