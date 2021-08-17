require("nvim-treesitter.configs").setup({

  ensure_installed = {
    "bash",
    "dockerfile",
    "elm",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "python",
    "scss",
    "toml",
    "tsx",
    "typescript",
    "vue",
    "yaml",
    "vim",
  },

  highlight = {
    enable = true,
  },

  indent = {
    enable = true,
  },

  incremental_selection = {
    enable = true,
  },

  matchup = {
    enable = true,
  },

  rainbow = {
    enable = true,
  },

  autotag = {
    enable = true,
  },
})
