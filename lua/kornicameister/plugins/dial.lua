local wk = require('which-key')

wk.register({
  ['<C-a>'] = { '<Plug>(dial-increment)', 'Increment' },
  ['<C-x>'] = { '<Plug>(dial-decrement)', 'Decrement' },
}, {
  noremap = false,
  silent = true,
  mode = 'n',
})

wk.register({
  ['<C-a>'] = { '<Plug>(dial-increment)', 'Increment' },
  ['<C-x>'] = { '<Plug>(dial-decrement)', 'Decrement' },
}, {
  noremap = false,
  silent = true,
  mode = 'v',
})
