local execute = vim.api.nvim_command
local fn = vim.fn
local g = vim.g

local packar_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(packar_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    "--depth",
    1,
    packar_path,
  })
  execute("packadd packer.nvim")
end

return require("packer").startup(function(use)
  -- self manage for packer
  use("wbthomason/packer.nvim")

  -- tree sitting monkey
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = [[ require('kornicameister.plugins.treesitter') ]],
    requires = { "p00f/nvim-ts-rainbow", "windwp/nvim-ts-autotag" },
  })

  -- LSP and shit
  use({
    {
      "neovim/nvim-lspconfig",
      config = [[ require('kornicameister.plugins.lsp') ]],
      requires = {
        "pierreglaser/folding-nvim",
        "nvim-lua/lsp-status.nvim",
        "RRethy/vim-illuminate",
        "onsails/lspkind-nvim",
        "ojroques/nvim-lspfuzzy",
        "williamboman/nvim-lsp-installer",
        {
          "folke/lsp-colors.nvim",
          config = function()
            require("lsp-colors").setup()
          end,
        },
        {
          "junegunn/fzf",
          run = "./install --all",
          requires = { "junegunn/fzf.vim" },
        },
      },
    },
    { "folke/trouble.nvim", config = [[ require("kornicameister.plugins.trouble") ]] },
  })

  -- testing
  use({
    "mfussenegger/nvim-dap",
    requires = {
      {
        "mfussenegger/nvim-dap-python",
        ft = { "python" },
        config = [[ require('kornicameister.plugins.dap') ]],
      },
    },
  })
  use({
    "nvim-neotest/neotest",
    after = {
      "which-key.nvim",
      "nvim-dap",
    },
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
    },
    config = [[ require('kornicameister.plugins.neotest') ]],
  })

  -- completion
  use({
    "hrsh7th/nvim-cmp",
    config = [[ require('kornicameister.plugins.completion') ]],
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      {
        "hrsh7th/vim-vsnip",
        requires = { "hrsh7th/vim-vsnip-integ", "rafamadriz/friendly-snippets" },
      },
      "f3fora/cmp-spell",
      "quangnguyen30192/cmp-nvim-tags",
    },
  })

  -- python
  use({
    { "raimon49/requirements.txt.vim", ft = { "requirements" } },
    { "tmhedberg/SimpylFold", ft = { "python" } },
    { "lambdalisue/vim-pyenv", ft = { "python" } },
  })

  -- other languages features
  use({
    { "gennaro-tedesco/nvim-jqx", ft = { "json", "yaml" } },
    { "lervag/vimtex", ft = "tex" },
    { "elzr/vim-json", ft = "json" },
  })

  -- git
  use({
    {
      "tpope/vim-fugitive",
      cmd = { "Git", "Gcommit", "Gstatus", "Gblame", "Gpush", "Gpull" },
    },
    "octref/rootignore",
    "tpope/vim-git",
    { "rhysd/git-messenger.vim", cmd = "GitMessenger", keys = "<leader>gm" },
    { "rhysd/committia.vim", setup = [[require('kornicameister.plugins.committia')]] },
    {
      "lewis6991/gitsigns.nvim",
      config = [[require('kornicameister.plugins.gitsigns')]],
      requires = { "nvim-lua/plenary.nvim" },
    },
  })

  -- editor enhanced
  use({
    {
      "nvim-telescope/telescope.nvim",
      config = [[ require("kornicameister.plugins.telescope") ]],
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "gbrlsnchs/telescope-lsp-handlers.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      },
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      setup = [[require('kornicameister.plugins.indentline')]],
    },
    {
      "RRethy/vim-hexokinase",
      run = "make hexokinase",
      cmd = "HexokinaseToggle",
      ft = {
        "lua",
        "python",
        "css",
        "scss",
        "sass",
        "elm",
        "typescript",
        "vue",
      },
      config = [[ require("kornicameister.plugins.hexokinase") ]],
    },
    {
      "mechatroner/rainbow_csv",
      ft = { "csv" },
    },
    "ConradIrwin/vim-bracketed-paste",
    "scrooloose/nerdcommenter",
    "tpope/vim-surround",
    "andymass/vim-matchup",
    "google/vim-searchindex",
    "triglav/vim-visual-increment",
    {
      "lewis6991/spellsitter.nvim",
      config = function()
        require("spellsitter").setup()
      end,
    },
    { "monaqa/dial.nvim", config = [[require("kornicameister.plugins.dial")]] },
    { "zhimsel/vim-stay", setup = [[require("kornicameister.plugins.vim-stay")]] },
    { "Vimjas/vim-python-pep8-indent", ft = { "python", "python3" } },
    "Glench/Vim-Jinja2-Syntax",
    "wgwoods/vim-systemd-syntax",
  })

  -- UI
  use({
    {
      "EdenEast/nightfox.nvim",
      config = [[ require('kornicameister.plugins.colorscheme') ]],
    },
    {
      "akinsho/nvim-bufferline.lua",
      config = [[ require("kornicameister.plugins.bufferline") ]],
      branch = "main",
    },
    {
      "hoob3rt/lualine.nvim",
      config = [[ require("kornicameister.plugins.lualine") ]],
    },
    "ryanoasis/vim-devicons",
    {
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup({ default = true })
      end,
    },
    "psliwka/vim-smoothie",
    "kosayoda/nvim-lightbulb",
  })

  -- other
  use({
    {
      "ludovicchabant/vim-gutentags",
      config = [[ require("kornicameister.plugins.gutentags") ]],
    },
    "tpope/vim-repeat",
    "svermeulen/vimpeccable",
    "wakatime/vim-wakatime",
    "lambdalisue/suda.vim",
    {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup({ presets = { g = true } })
      end,
    },
    {
      "antoinemadec/FixCursorHold.nvim",
      config = function()
        vim.g.curshold_updatime = 1000
      end,
    },
    {
      "iamcco/markdown-preview.nvim",
      run = "cd app && yarn install",
      cmd = "MarkdownPreview",
    },
  })
end)
