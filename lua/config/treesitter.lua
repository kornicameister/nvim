require("nvim-treesitter.configs").setup({

  ensure_installed = {
    "bash",
    "dockerfile",
    "elm",
    "go",
    "html",
    "java",
    "javascript",
    "json",
    "lua",
    "python",
    "scss",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
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
