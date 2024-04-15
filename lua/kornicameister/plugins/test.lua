return {

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
      'marilari88/neotest-vitest',
    },
    config = function()
      local neotest = require('neotest')
      local whichKey = require('which-key')

      neotest.setup({
        adapters = {
          require('neotest-vitest'),
          require('neotest-python')({
            dap = { justMyCode = false },
            args = { '--log-level', 'DEBUG' },
          }),
        },
      })

      whichKey.register({
        ['f'] = {
          "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
          'test: file',
        },
        ['t'] = {
          "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
          'test: cursor',
        },
        ['s'] = {
          "<cmd>lua require('neotest').summary.toggle()<cr>",
          'test: summary',
        },
        ['o'] = {
          "<cmd>lua require('neotest').output.open({ enter = true })<cr>",
          'test: summary',
        },
        ['l'] = {
          "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>",
          'test: rerun last',
        },
      }, {
        prefix = '<leader>t',
        noremap = true,
        silent = true,
      })

      whichKey.register({
        ['[f'] = {
          "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<cr>",
          'test: previous failed',
        },
        [']f'] = {
          "<cmd>lua require('neotest').jump.next({ status = 'failed' })<cr>",
          'test: next failed',
        },
      }, {
        noremap = true,
        silent = true,
      })
    end,
  },
}
