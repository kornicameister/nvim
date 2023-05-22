local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.load_extension('lsp_handlers')
telescope.load_extension('zoxide')

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim', -- add this value
    },
    mappings = {
      i = {
        ['<esc>'] = actions.close,
      },
    },
  },
  extensions = {
    lsp_handlers = {
      code_action = {
        telescope = require('telescope.themes').get_dropdown({}),
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
      frecency = {
        show_score = true,
      },
    },
  },
})

telescope.load_extension('fzf')
telescope.load_extension('ui-select')

require('which-key').register({
  ['<leader>'] = {
    "<cmd>lua require('telescope.builtin').git_files()<cr>",
    'Telescope: git',
  },
  ['<leader><leader>'] = {
    "<cmd>lua require('telescope.builtin').find_files()<cr>",
    'Telescope: files',
  },
  ['s'] = {
    "<cmd>lua require('telescope.builtin').treesitter()<cr>",
    'Telescope: symbols',
  },
  ['b'] = {
    "<cmd>lua require('telescope.builtin').buffers()<cr>",
    'Telescope: buffers',
  },
  ['w'] = {
    "<cmd>lua require('telescope.builtin').grep_string()<cr>",
    'Telescope: find word',
  },
  ['F'] = {
    "<cmd>lua require('telescope.builtin').live_grep()<cr>",
    'Telescope: look everywhere',
  },
  ['gs'] = {
    "<cmd>lua require('telescope.builtin').git_status()<cr>",
    'Telescope: git status',
  },
  ['gb'] = {
    "<cmd>lua require('telescope.builtin').git_branches()<cr>",
    'Telescope: git branches',
  },
  ['cd'] = {
    "<cmd>lua require('telescope').extensions.zoxide.list()<cr>",
    'Telescope: git branches',
  },
}, {
  prefix = '<leader>',
  noremap = true,
  silent = true,
})
