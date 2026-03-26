return {
  {
    "mason-org/mason-lspconfig.nvim",
    event = 'VeryLazy',
    config = function()
      require('config.lsp')
    end,
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
      {
        'RRethy/vim-illuminate',
        -- treesitter provider broken with nvim-treesitter v2 (define_modules removed)
        config = function()
          require('illuminate').configure({
            providers = { 'lsp', 'regex' },
          })
        end,
      },
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
      'kosayoda/nvim-lightbulb',
    },
  },
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    config = function()
      require('fidget').setup({})
    end,
  },

  {
    'mbarneyjr/iam-legend-lsp',
    ft = { 'yaml.cloudformation', 'json.cloudformation' },
    build = 'npm install',
  },
}
