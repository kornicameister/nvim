local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = require('config.lazy')
require('lazy').setup({
  { import = 'plugins.lazy' },
  { import = 'plugins.ui' },
  { import = 'plugins.lsp' },
  { import = 'plugins.treesitter' },
  { import = 'plugins.editor' },
  { import = 'plugins.monorepo' },
  { import = 'plugins.git' },
  { import = 'plugins.test' },

  { import = 'lang.csv' },
  { import = 'lang.oas' },

  -- completion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      require('plugins.completion')
    end,
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      {
        'hrsh7th/vim-vsnip',
        dependencies = {
          'hrsh7th/vim-vsnip-integ',
          'rafamadriz/friendly-snippets',
        },
      },
      'f3fora/cmp-spell',
      'quangnguyen30192/cmp-nvim-tags',
    },
  },

  -- editor enhanced
  'ConradIrwin/vim-bracketed-paste',
  'scrooloose/nerdcommenter',
  'tpope/vim-surround',
  'andymass/vim-matchup',
  'google/vim-searchindex',
  'triglav/vim-visual-increment',

  -- python
  { 'lambdalisue/vim-pyenv', lazdy = true, ft = { 'python' } },
  {
    'Vimjas/vim-python-pep8-indent',
    lazy = true,
    ft = { 'python', 'python3' },
  },
  {
    'mfussenegger/nvim-dap-python',
    lazy = true,
    ft = { 'python' },
    dependencies = { 'nvim-neotest/neotest', 'mfussenegger/nvim-dap' },
    config = function()
      require('plugins.dap')
    end,
  },

  -- other languages features
  { 'gennaro-tedesco/nvim-jqx',   ft = { 'json', 'yaml' } },
  { 'elzr/vim-json',              ft = 'json' },
  { 'lervag/vimtex',              ft = 'tex' },
  { 'Glench/Vim-Jinja2-Syntax',   ft = { 'jinja2' } },
  { 'wgwoods/vim-systemd-syntax', ft = { 'systemd' } },

  {
    'folke/which-key.nvim',
    branch = 'main',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require('which-key').setup({ presets = { g = true } })
    end,
  },

  -- other
  {
    'ludovicchabant/vim-gutentags',
    config = function()
      require('plugins.gutentags')
    end,
  },
  'tpope/vim-repeat',
  'svermeulen/vimpeccable',
  { 'wakatime/vim-wakatime', lazy = false },
  'lambdalisue/suda.vim',
}, lazy_config)
