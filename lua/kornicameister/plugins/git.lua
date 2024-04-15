return {
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
        '<A-.>',
        function()
          require('gitsigns.actions').stage_hunk()
        end,
        desc = 'Git: stage change',
      },
      {
        '<A-,>',
        function()
          require('gitsigns.actions').reset_hunk()
        end,
        desc = 'Git: reset change',
      },
    },
    config = function()
      require('gitsigns').setup({
        numhl = true,
        linehl = false,
        signs = {
          add = { hl = 'GitSignsAdd', text = '', numhl = 'GitSignsAddNr' },
          delete = {
            hl = 'GitSignsDelete',
            text = '',
            numhl = 'GitSignsDeleteNr',
          },
          change = {
            hl = 'GitSignsChange',
            text = '',
            numhl = 'GitSignsChangeNr',
          },
          changedelete = {
            hl = 'GitSignsDelete',
            text = '',
            numhl = 'GitSignsChangeNr',
          },
          topdelete = {
            hl = 'GitSignsDelete',
            text = '',
            numhl = 'GitSignsDeleteNr',
          },
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
