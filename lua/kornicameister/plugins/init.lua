local execute = vim.api.nvim_command
local fn = vim.fn

local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not vim.loop.fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').setup{
  max_jobs            = 5,
  autoremove          = true,
  autoinstall         = true,
  git = {
    depth = 5,
  },
  log = { level = 'debug' },
  lockfile = {
    path = './pckr.lock.lua'
  }
}

require('pckr').add({
  -- self manage packer
  'lewis6991/pckr.nvim',

  -- tree sitting monkey
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = 'kornicameister.plugins.treesitter',
    requires = { 'p00f/nvim-ts-rainbow', 'windwp/nvim-ts-autotag' },
  },

  -- LSP and shit
  {
    'neovim/nvim-lspconfig',
    config = 'kornicameister.plugins.lsp',
    after = { 'hrsh7th/nvim-cmp' },
    requires = {
      'pierreglaser/folding-nvim',
      'nvim-lua/lsp-status.nvim',
      'RRethy/vim-illuminate',
      'onsails/lspkind-nvim',
      'ojroques/nvim-lspfuzzy',
      {
        'williamboman/mason.nvim',
        requires = { 'williamboman/mason-lspconfig.nvim', branch = 'main' },
      },
      {
        'folke/lsp-colors.nvim',
        config = function()
          require('lsp-colors').setup()
        end,
      },
      {
        'junegunn/fzf',
        run = './install --all',
        requires = { 'junegunn/fzf.vim' },
      },
    },
  },
  {
    'folke/trouble.nvim',
    branch = 'main',
    config = 'kornicameister.plugins.trouble',
  },

  -- testing
  'mfussenegger/nvim-dap',
  {
    'nvim-neotest/neotest',
    after = {
      'which-key.nvim',
      'nvim-dap',
    },
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-python',
      'nvim-neotest/nvim-nio',
    },
    config = 'kornicameister.plugins.neotest',
  },
  {
    'mfussenegger/nvim-dap-python',
    ft = { 'python' },
    after = { 'neotest', 'nvim-dap' },
    config = 'kornicameister.plugins.dap',
  },

  -- completion
  {
    'hrsh7th/nvim-cmp',
    config = 'kornicameister.plugins.completion',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      {
        'hrsh7th/vim-vsnip',
        requires = { 'hrsh7th/vim-vsnip-integ', 'rafamadriz/friendly-snippets' },
      },
      'f3fora/cmp-spell',
      'quangnguyen30192/cmp-nvim-tags',
    },
  },

  -- python
  { 'raimon49/requirements.txt.vim', ft = { 'requirements' } },
  { 'tmhedberg/SimpylFold', ft = { 'python' } },
  { 'lambdalisue/vim-pyenv', ft = { 'python' } },

  -- other languages features
  { 'gennaro-tedesco/nvim-jqx', ft = { 'json', 'yaml' } },
  { 'lervag/vimtex', ft = 'tex' },
  { 'elzr/vim-json', ft = 'json' },

  -- git
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'Gcommit', 'Gstatus', 'Gblame', 'Gpush', 'Gpull' },
  },
  'octref/rootignore',
  'tpope/vim-git',
  { 'rhysd/git-messenger.vim', cmd = 'GitMessenger', keys = '<leader>gm' },
  {
    'rhysd/committia.vim',
    setup = 'kornicameister.plugins.committia',
  },
  {
    'lewis6991/gitsigns.nvim',
    config = 'kornicameister.plugins.gitsigns',
    requires = { 'nvim-lua/plenary.nvim' },
  },

  -- editor enhanced
  {
    'nvim-telescope/telescope.nvim',
    config = 'kornicameister.plugins.telescope',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'gbrlsnchs/telescope-lsp-handlers.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      'jvgrootveld/telescope-zoxide',
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    setup = 'kornicameister.plugins.indentline',
  },
  {
    'RRethy/vim-hexokinase',
    run = 'make hexokinase',
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
    config = 'kornicameister.plugins.hexokinase',
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
  { 'monaqa/dial.nvim', config = 'kornicameister.plugins.dial' },
  {
    'zhimsel/vim-stay',
    setup = 'kornicameister.plugins.vim-stay',
  },
  { 'Vimjas/vim-python-pep8-indent', ft = { 'python', 'python3' } },
  'Glench/Vim-Jinja2-Syntax',
  'wgwoods/vim-systemd-syntax',
  {
    'kwkarlwang/bufjump.nvim',
    config = 'kornicameister.plugins.bufjump',
  },

  -- UI
  {
    'EdenEast/nightfox.nvim',
    config = 'kornicameister.plugins.colorscheme',
  },
  {
    'akinsho/nvim-bufferline.lua',
    config = 'kornicameister.plugins.bufferline',
    branch = 'main',
  },
  {
    'hoob3rt/lualine.nvim',
    config = 'kornicameister.plugins.lualine',
  },
  'ryanoasis/vim-devicons',
  {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({ default = true })
    end,
  },
  'psliwka/vim-smoothie',
  'kosayoda/nvim-lightbulb',

  -- other
  {
    'ludovicchabant/vim-gutentags',
    config = 'kornicameister.plugins.gutentags',
  },
  'tpope/vim-repeat',
  'svermeulen/vimpeccable',
  'wakatime/vim-wakatime',
  'lambdalisue/suda.vim',
  {
    'folke/which-key.nvim',
    branch = 'main',
    config = vim.defer_fn(function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require('which-key').setup({ presets = { g = true } })
    end, 100),
  },
  {
    'antoinemadec/FixCursorHold.nvim',
    config = function()
      vim.g.curshold_updatime = 1000
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    cmd = 'MarkdownPreview',
  },
})
