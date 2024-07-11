return {

  {
    'imNel/monorepo.nvim',
    config = function()
      require('monorepo').setup({})
      require('telescope').load_extension('monorepo')
    end,
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  },
}
