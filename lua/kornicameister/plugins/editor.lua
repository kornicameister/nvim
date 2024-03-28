return {
  {
    'nvim-pack/nvim-spectre',
    build = false,
    cmd = 'Spectre',
    opts = { open_cmd = 'noswapfile vnew' },
    keys = {
      {
        '<leader>/',
        function()
          require('spectre').open()
        end,
        desc = 'Replace in Files (Spectre)',
      },
    },
  },
}
