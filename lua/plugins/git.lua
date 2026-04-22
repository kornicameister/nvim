return {
  { 'tpope/vim-git', event = 'VeryLazy' },
  { 'octref/rootignore', event = 'VeryLazy' },
  {
    'rhysd/committia.vim',
    ft = 'gitcommit',
    init = function()
      vim.g.committia_hooks = {
        edit_open = function()
          vim.opt_local.spell = true
          vim.opt_local.spelllang = 'en'
          vim.opt_local.colorcolumn = '50,72'
          vim.opt_local.textwidth = 72

          -- Start in insert mode if commit message is empty
          if vim.fn.getline(1) == '' then
            vim.cmd('startinsert')
          end

          -- Scroll diff from insert mode
          local opts = { buffer = true }
          vim.keymap.set('i', '<C-n>', '<Plug>(committia-scroll-diff-down-half)', opts)
          vim.keymap.set('i', '<C-p>', '<Plug>(committia-scroll-diff-up-half)', opts)
        end,
        diff_open = function()
          vim.opt_local.number = true
        end,
      }
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
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    config = function()
      require('diffview').setup()
    end,
  },
}
