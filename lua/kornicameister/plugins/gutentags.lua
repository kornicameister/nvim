vim.g.gutentags_ctags_tagfile = ".git/tags"
vim.g.gutentags_file_list_command = {
  markers = {
    [".git"] = 'git grep --cached -I -l -e $""',
  },
}
