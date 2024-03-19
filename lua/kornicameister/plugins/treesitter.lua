require('nvim-treesitter.configs').setup({

  ensure_installed = {
    'bash',
    'dockerfile',
    'elm',
    'go',
    'html',
    'java',
    'javascript',
    'json',
    'lua',
    'python',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vue',
    'yaml',
  },
  sync_install = true,

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = {
    enable = true,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
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
