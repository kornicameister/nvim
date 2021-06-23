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
  },

  highlight = {
    enable = true,
  },

  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },

    smart_rename = {
      enable = false,
      keymaps = {
        smart_rename = "grr",
      },
    },
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
})
