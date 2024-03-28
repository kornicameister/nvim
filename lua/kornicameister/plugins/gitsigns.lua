require('gitsigns').setup({
  numhl = true,
  linehl = false,
  signs = {
    add = { hl = 'GitSignsAdd', text = '', numhl = 'GitSignsAddNr' },
    delete = { hl = 'GitSignsDelete', text = '', numhl = 'GitSignsDeleteNr' },
    change = { hl = 'GitSignsChange', text = '', numhl = 'GitSignsChangeNr' },
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

require('which-key').register({
  ['n ]c'] = {
    '<cmd>lua require"gitsigns.actions".next_hunk()<CR>',
    'Next hunk',
  },
  ['n [c'] = {
    '<cmd>lua require"gitsigns.actions".prev_hunk()<CR>',
    'Previous hunk',
  },
  ['n <A-,>'] = {
    "<cmd>lua require('gitsigns').reset_hunk()<CR>",
    'Reset hunk',
  },
  ['n <A-.>'] = {
    "<cmd>lua require('gitsigns').stage_hunk()<CR>",
    'Stage hunk',
  },
  ['n <A-/>'] = {
    "<cmd>lua require('gitsigns').preview_hunk()<CR>",
    'Preview hunk',
  },
}, { silent = true, noremap = true, buffer = true })
