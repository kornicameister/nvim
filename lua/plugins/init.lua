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
  { import = 'lang.python' },

  -- completion
  {
    'saghen/blink.cmp',
    version = '1.*',
    event = 'InsertEnter',
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = require('plugins.completion'),
  },

  -- editor enhanced
  { 'tpope/vim-surround', event = 'VeryLazy' },
  { 'andymass/vim-matchup', event = 'BufReadPost' },
  { 'triglav/vim-visual-increment', event = 'VeryLazy' },

  -- other languages features
  { 'gennaro-tedesco/nvim-jqx', ft = { 'json', 'yaml' } },
  { 'elzr/vim-json', ft = 'json' },
  { 'lervag/vimtex', ft = 'tex' },
  { 'Glench/Vim-Jinja2-Syntax', ft = { 'jinja2' } },
  { 'wgwoods/vim-systemd-syntax', ft = { 'systemd' } },

  {
    'folke/which-key.nvim',
    branch = 'main',
    event = 'VeryLazy',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require('which-key').setup({ presets = { g = true } })
    end,
  },

  -- other
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  { 'lambdalisue/suda.vim', cmd = { 'SudaRead', 'SudaWrite' } },
}, lazy_config)
