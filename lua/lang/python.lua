return {
  { 'Vimjas/vim-python-pep8-indent', lazy = true, ft = { 'python', 'python3' } },
  {
    'mfussenegger/nvim-dap-python',
    lazy = true,
    ft = 'python',
    dependencies = { 'nvim-neotest/neotest', 'mfussenegger/nvim-dap' },
    config = function()
      require('dap-python').setup('~/.pyenv/versions/debugpy/bin/python')
    end,
  },
  {
    'nvim-neotest/neotest-python',
    lazy = true,
    ft = 'python',
  },
}
