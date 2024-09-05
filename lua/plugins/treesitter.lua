local init_selection = 'gnn'

return {
  -- Treesitter is a new parser generator tool that we can
  -- use in Neovim to power faster and more accurate
  -- syntax highlighting.
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    init = function()
      require('nvim-treesitter.query_predicates')
    end,

    keys = {
      { init_selection, desc = 'Increment Selection' },
    },
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },

    config = function()
      ---@type TSConfig
      ---@diagnostic disable-next-line: missing-fields
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
        auto_install = true,
        sync_install = false,

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
            init_selection = init_selection,
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
    end,
    dependencies = { 'p00f/nvim-ts-rainbow', 'windwp/nvim-ts-autotag' },
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    enabled = true,
    opts = { mode = 'cursor', max_lines = 3 },
    keys = {
      {
        '<leader>ut',
        function()
          local tsc = require('treesitter-context')
          tsc.toggle()
        end,
        desc = 'Toggle Treesitter Context',
      },
    },
  },
}
