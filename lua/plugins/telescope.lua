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
    lazy = {},
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
telescope.load_extension('lazy')
telescope.load_extension('ui-select')
telescope.load_extension('package_info')

require('which-key').add({
  { '<leader><leader>', "<cmd>lua require('telescope.builtin').git_files()<cr>", desc = 'Telescope: git' },
  { '<leader><leader><leader>', "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = 'Telescope: files' },
  { '<leader>bs', "<cmd>lua require('telescope.builtin').treesitter()<cr>", desc = 'Telescope: buffer symbols' },
  { '<leader>ws', "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", desc = 'Telescope: workspace symbols' },
  { '<leader>b', "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = 'Telescope: buffers' },
  { '<leader>w', "<cmd>lua require('telescope.builtin').grep_string()<cr>", desc = 'Telescope: find word' },
  { '<leader>F', "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = 'Telescope: look everywhere' },
  { '<leader>gs', "<cmd>lua require('telescope.builtin').git_status()<cr>", desc = 'Telescope: git status' },
  { '<leader>gb', "<cmd>lua require('telescope.builtin').git_branches()<cr>", desc = 'Telescope: git branches' },
  { '<leader>cd', "<cmd>lua require('telescope').extensions.zoxide.list()<cr>", desc = 'Telescope: zoxide' },
})
