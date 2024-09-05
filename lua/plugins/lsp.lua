return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('config.lsp')
    end,
    dependencies = {
      'pierreglaser/folding-nvim',
      'nvim-lua/lsp-status.nvim',
      'RRethy/vim-illuminate',
      'onsails/lspkind-nvim',
      'ojroques/nvim-lspfuzzy',
      'folke/neodev.nvim',
      'kosayoda/nvim-lightbulb',
      {
        'williamboman/mason.nvim',
        dependencies = { 'williamboman/mason-lspconfig.nvim', branch = 'main' },
      },
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
