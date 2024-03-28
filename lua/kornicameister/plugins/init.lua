local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = require('config.lazy')
require('lazy').setup({
  -- self manage packer
  'folke/lazy.nvim',

  -- target configuration
  { import = 'kornicameister.plugins.treesitter' },
  { import = 'kornicameister.plugins.editor' },
  { import = 'kornicameister.plugins.ui' },

  -- LSP and shit
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('kornicameister.plugins.lsp')
    end,
    dependencies = {
      'pierreglaser/folding-nvim',
      'nvim-lua/lsp-status.nvim',
      'RRethy/vim-illuminate',
      'onsails/lspkind-nvim',
      'ojroques/nvim-lspfuzzy',
      'folke/neodev.nvim',
      {
        'williamboman/mason.nvim',
        dependencies = { 'williamboman/mason-lspconfig.nvim', branch = 'main' },
      },
      {
        'folke/lsp-colors.nvim',
        config = function()
          require('lsp-colors').setup()
        end,
      },
      {
        'junegunn/fzf',
        build = './install --all',
        dependencies = { 'junegunn/fzf.vim' },
      },
    },
  },

  -- completion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      require('kornicameister.plugins.completion')
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
  {
    'folke/trouble.nvim',
    branch = 'main',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('kornicameister.plugins.trouble')
    end,
  },

  -- editor enhanced
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('kornicameister.plugins.telescope')
    end,
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'gbrlsnchs/telescope-lsp-handlers.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'jvgrootveld/telescope-zoxide',
    },
  },

  {
    'RRethy/vim-hexokinase',
    build = 'make hexokinase',
    cmd = 'HexokinaseToggle',
    ft = {
      'lua',
      'python',
      'css',
      'scss',
      'sass',
      'elm',
      'typescript',
      'vue',
    },
    config = function()
      require('kornicameister.plugins.hexokinase')
    end,
  },

  {
    'mechatroner/rainbow_csv',
    ft = { 'csv' },
  },
  'ConradIrwin/vim-bracketed-paste',
  'scrooloose/nerdcommenter',
  'tpope/vim-surround',
  'andymass/vim-matchup',
  'google/vim-searchindex',
  'triglav/vim-visual-increment',
  {
    'lewis6991/spellsitter.nvim',
    config = function()
      require('spellsitter').setup()
    end,
  },
  {
    'monaqa/dial.nvim',
    config = function()
      require('kornicameister.plugins.dial')
    end,
  },
  {
    'zhimsel/vim-stay',
    init = function()
      require('kornicameister.plugins.vim-stay')
    end,
  },
  {
    'kwkarlwang/bufjump.nvim',
    config = function()
      require('kornicameister.plugins.bufjump')
    end,
  },

  -- testing
  'mfussenegger/nvim-dap',
  {
    'nvim-neotest/neotest',
    dependencies = {
      'antoinemadec/FixCursorHold.nvim',
      'nvim-dap',
      'nvim-lua/plenary.nvim',
      'nvim-neotest/neotest-python',
      'nvim-neotest/nvim-nio',
      'nvim-treesitter/nvim-treesitter',
      'which-key.nvim',
    },
    config = function()
      require('kornicameister.plugins.neotest')
    end,
  },

  -- git
  'tpope/vim-git',
  'octref/rootignore',
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'Gcommit', 'Gstatus', 'Gblame', 'Gpush', 'Gpull' },
  },
  {
    'rhysd/committia.vim',
    init = function()
      require('kornicameister.plugins.committia')
    end,
  },
  {
    'rhysd/git-messenger.vim',
    cmd = 'GitMessenger',
    keys = {
      { '<leader>gm', '<cmd>GitMessenger<cr>', desc = 'NeoTree' },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPost',
    config = function()
      require('kornicameister.plugins.gitsigns')
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- UI
  {
    'EdenEast/nightfox.nvim',
    config = function()
      require('kornicameister.plugins.colorscheme')
    end,
  },
  {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({ default = true })
    end,
  },
  'psliwka/vim-smoothie',
  'kosayoda/nvim-lightbulb',

  -- python
  { 'raimon49/requirements.txt.vim', lazy = true, ft = { 'requirements' } },
  { 'tmhedberg/SimpylFold', lazy = true, ft = { 'python' } },
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
      require('kornicameister.plugins.dap')
    end,
  },

  -- other languages features
  { 'gennaro-tedesco/nvim-jqx', ft = { 'json', 'yaml' } },
  { 'lervag/vimtex', ft = 'tex' },
  { 'elzr/vim-json', ft = 'json' },
  { 'Glench/Vim-Jinja2-Syntax', ft = { 'jinja2' } },
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
  {
    'antoinemadec/FixCursorHold.nvim',
    config = function()
      vim.g.curshold_updatime = 1000
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npx --yes yarn install',
    cmd = 'MarkdownPreview',
  },

  -- other
  {
    'ludovicchabant/vim-gutentags',
    config = function()
      require('kornicameister.plugins.gutentags')
    end,
  },
  'tpope/vim-repeat',
  'svermeulen/vimpeccable',
  'wakatime/vim-wakatime',
  'lambdalisue/suda.vim',
}, lazy_config)
