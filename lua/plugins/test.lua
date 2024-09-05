return {

  'mfussenegger/nvim-dap',
  {
    'nvim-neotest/neotest',
    lazy = true,
    dependencies = {
      'nvim-dap',
      'nvim-lua/plenary.nvim',
      'nvim-neotest/neotest-python',
      'nvim-neotest/nvim-nio',
      'nvim-treesitter/nvim-treesitter',
      'which-key.nvim',
      'marilari88/neotest-vitest',
    },
    keys = {
      {
        '<leader>tf',
        function()
          require('neotest').run.run({ strategy = 'dap', suite = true })
        end,
        desc = 'test: all',
      },
      {
        '<leader>tt',
        function()
          require('neotest').run.run({ strategy = 'dap', suite = false })
        end,
        desc = 'test: highlighted',
      },
      {
        '<leader>tl',
        function()
          require('neotest').run.run_last({ strategy = 'dap', suite = false })
        end,
        desc = 'test: rerun',
      },
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'test: summary',
      },
      {
        '[f',
        function()
          require('neotest').jump.prev({ status = 'failed' })
        end,
        desc = 'test: previous fail',
      },
      {
        ']f',
        function()
          require('neotest').jump.next({ status = 'failed' })
        end,
        desc = 'test: next fail',
      },
    },
    config = function()
      local neotest = require('neotest')
      neotest.setup({
        adapters = {
          require('neotest-vitest')({
            vitestCommand = 'npx vitest',
          }),
          require('neotest-python')({
            dap = { justMyCode = false },
            args = { '--log-level', 'DEBUG' },
          }),
        },
      })
    end,
  },
}
