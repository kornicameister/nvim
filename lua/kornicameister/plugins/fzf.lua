require("which-key").register({
  -- tags
  ["t"] = { "<CMD>Tags<CR>", "fzf: tags" },
  ["bt"] = { "<CMD>BTags<CR>", "fzf: btags" },
  -- files
  ["f"] = { "<CMD>GFiles<CR>", "fzf: git files" },
  ["F"] = { "<CMD>Files<CR>", "fzf: all files" },
  -- commits
  ["c"] = { "<CMD>Commits<CR>", "fzf: commits" },
  ["bc"] = { "<CMD>BCommits<CR>", "fzf: commits" },
  -- general
  ["b"] = { "<CMD>Buffers<CR>", "fzf: buffers" },
  ["h"] = { "<CMD>History<CR>", "fzf: history" },
}, {
  prefix = "<leader>",
  silent = true,
  noremap = true,
})

vim.g.fzf_layout = {
  window = {
    width = 0.9,
    height = 0.6,
  },
}
vim.g.fzf_buffers_jump = true
