return {
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require('config.lsp')
    end,
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
      'pierreglaser/folding-nvim',
      'nvim-lua/lsp-status.nvim',
      'RRethy/vim-illuminate',
      'onsails/lspkind-nvim',
      'ojroques/nvim-lspfuzzy',
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
      {
        'junegunn/fzf',
        build = './install --all',
        dependencies = { 'junegunn/fzf.vim' },
      },
    },
  },
  {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup({})
    end,
  },
}
