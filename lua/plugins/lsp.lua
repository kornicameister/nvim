return {
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require('config.lsp')
    end,
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
      'RRethy/vim-illuminate',
      'onsails/lspkind-nvim',
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
    config = function()
      require('fidget').setup({})
    end,
  },
}
