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
    config = [[ require('config.treesitter') ]],
    requires = { "p00f/nvim-ts-rainbow", "windwp/nvim-ts-autotag" },
  })

  -- LSP and shit
  use({
    {
      "neovim/nvim-lspconfig",
      config = [[ require('config.lsp') ]],
      requires = {
        "pierreglaser/folding-nvim",
        "nvim-lua/lsp-status.nvim",
        "RRethy/vim-illuminate",
        { "liuchengxu/vista.vim", config = [[ require("config.vista") ]] },
      },
    },
    {
      "kabouzeid/nvim-lspinstall",
      config = function()
        require("lspinstall").setup()
      end,
    },
    {
      "ojroques/nvim-lspfuzzy",
      config = function()
        require("lspfuzzy").setup({
          methods = "all",
          fzf_action = { ["ctrl-v"] = "vsplit", ["ctrl-x"] = "split" },
        })
      end,
    },
    { "folke/trouble.nvim", config = [[ require("plugins.trouble") ]] },
  })

  -- completion
  use({
    "hrsh7th/nvim-compe",
    config = [[ require('config.completion') ]],
    requires = { "hrsh7th/vim-vsnip", "hrsh7th/vim-vsnip-integ" },
  })

  use({
    -- python
    { "raimon49/requirements.txt.vim", ft = { "requirements" } },
    { "tmhedberg/SimpylFold", ft = { "python" } },
    { "vim-scripts/indentpython.vim", ft = { "python" } },
    { "lambdalisue/vim-pyenv", ft = { "python" } }, -- json
    { "gennaro-tedesco/nvim-jqx", ft = { "json", "yaml" } }, -- latex
    { "lervag/vimtex", ft = "tex" },
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
    { "rhysd/committia.vim", setup = [[require('config.committia')]] },
    {
      "lewis6991/gitsigns.nvim",
      config = [[require('config.gitsigns')]],
      requires = { "nvim-lua/plenary.nvim" },
    },
  })

  -- editor enhanced
  use({
    {
      "nvim-telescope/telescope.nvim",
      config = function()
        require("telescope").setup()
      end,
      requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      setup = [[require('config.indentline')]],
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
      config = function()
        vim.g.Hexokinase_highlighters = { "virtual" }
      end,
    },
    "ConradIrwin/vim-bracketed-paste",
    "scrooloose/nerdcommenter",
    "tpope/vim-surround",
    "andymass/vim-matchup",
    "google/vim-searchindex",
    "triglav/vim-visual-increment",
    { "monaqa/dial.nvim", config = [[require("plugins.dial")]] },
    { "zhimsel/vim-stay", setup = [[require("config.matchup")]] },
    {
      "junegunn/fzf",
      run = "./install --all",
      config = [[require("config.fzf")]],
      requires = { "junegunn/fzf.vim" },
    },
  })

  -- UI
  use({
    {
      "rafamadriz/neon",
      config = [[ require('config.colorscheme') ]],
    },
    {
      "akinsho/nvim-bufferline.lua",
      config = [[ require("config.bufferline") ]],
    },
    { "hoob3rt/lualine.nvim", config = [[ require("config.lualine") ]] },
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
      config = [[ require("config.gutentags") ]],
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
