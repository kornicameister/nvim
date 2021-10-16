local opts = { silent = true, noremap = true }

require("which-key").register({
  -- tags
  ["<leader>t"] = { "<CMD>Tags<CR>", "fzf: tags" },
  ["<leader>bt"] = { "<CMD>BTags<CR>", "fzf: btags" },
  -- files
  ["<leader>f"] = { "<CMD>GFiles<CR>", "fzf: git files" },
  ["<leader>F"] = { "<CMD>Files<CR>", "fzf: all files" },
  -- commits
  ["<leader>c"] = { "<CMD>Commits<CR>", "fzf: commits" },
  ["<leader>bc"] = { "<CMD>BCommits<CR>", "fzf: commits" },
  -- general
  ["<leader>b"] = { "<CMD>Buffers<CR>", "fzf: buffers" },
  ["<leader>h"] = { "<CMD>History<CR>", "fzf: history" },
}, opts)

vim.g.fzf_layout = {
  window = {
    width = 0.9,
    height = 0.6,
  },
}
vim.g.fzf_buffers_jump = true
