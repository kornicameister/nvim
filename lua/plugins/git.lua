return {
  'tpope/vim-git',
  'octref/rootignore',
  {
    'rhysd/committia.vim',
    init = function()
      local g = vim.g

      g.committia_hooks = {}

      -- Scroll the diff window from insert mode
      -- Map <A-n> and <A-p>
      vim.keymap.set('i', '<A-n>', '<Plug>(committia-scroll-diff-down-half', { buffer = true })
      vim.keymap.set('i', '<A-p>', '<Plug>(committia-scroll-diff-up-half)', { buffer = true })
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
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPost',
    keys = {
      {
        ']c',
        function()
          require('gitsigns.actions').nav_hunk('next')
        end,
        desc = 'Git: next change',
      },
      {
        '[c',
        function()
          require('gitsigns.actions').nav_hunk('prev')
        end,
        desc = 'Git: previous change',
      },
      {
        '<C-.>',
        function()
          require('gitsigns.actions').stage_hunk()
        end,
        desc = 'Git: stage change',
      },
      {
        '<C-,>',
        function()
          require('gitsigns.actions').reset_hunk()
        end,
        desc = 'Git: reset change',
      },
      {
        '<leader>gbb',
        '<cmd>Gitsigns blame<cr>',
        desc = 'Git: blame (buffer)',
      },
      {
        '<leader>gbl',
        '<cmd>Gitsigns blame_line<cr>',
        desc = 'Git: blame (line)',
      },
    },
    config = function()
      require('gitsigns').setup({
        numhl = true,
        linehl = false,
        signs = {
          add = { text = '' },
          delete = { text = '' },
          change = { text = '' },
          changedelete = { text = '' },
          topdelete = { text = '' },
        },
      })
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'sindrets/diffview.nvim',
    config = function()
      require('diffview').setup()
    end,
  },
}
