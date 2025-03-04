return {
  'psliwka/vim-smoothie',

  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    keys = {
      {
        '<space><space>',
        'za',
        desc = 'Toggle fold',
      },
      {
        'zR',
        function()
          require('ufo').openAllFolds()
        end,
      },
      {
        'zM',
        function()
          require('ufo').closeAllFolds()
        end,
      },
    },
    opts = {
      enable_get_fold_virt_text = true,
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
    },
  },
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require('onedark').setup({
        style = 'darker',
      })

      vim.opt.termguicolors = true
      vim.opt.background = 'dark'
      vim.cmd([[colorscheme onedark]])
    end,
  },
  {
    'RRethy/vim-hexokinase',
    build = 'make hexokinase',
    cmd = 'HexokinaseToggle',
    ft = {
      'lua',
      'python',
      'css',
      'scss',
      'sass',
      'elm',
      'typescript',
      'vue',
    },
    config = function()
      vim.g.Hexokinase_highlighters = { 'virtual' }
    end,
  },
  {
    'akinsho/nvim-bufferline.lua',
    branch = 'main',
    event = 'VimEnter',
    keys = {
      { '<leader>q', '<Cmd>bd<CR>gT', desc = 'Close buffer' },
      { '<S-Tab>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<Tab>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    },
    config = function()
      vim.opt.termguicolors = true

      require('bufferline').setup({
        options = {
          numbers = 'buffer_id',
          modified_icon = '✥',
          separator_style = 'thin',
          -- diagnostics setup
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(count, level, _, context)
            if context.buffer:current() then
              return ''
            end
            local icon = level:match('error') and ' ' or ''
            return ' ' .. icon .. ' ' .. count
          end,
          -- closing setup
          buffer_close_icon = '',
          show_buffer_close_icons = false,
          close_command = function(n)
            require('mini.bufremove').delete(n, false)
          end,
          right_mouse_command = function(n)
            require('mini.bufremove').delete(n, false)
          end,
        },
      })

      local opts = {
        noremap = true,
        silent = true,
      }

      vim.api.nvim_set_keymap('n', '<leader>Q', [[ :bufdo bd<CR> ]], opts)
      vim.api.nvim_set_keymap('n', '<leader>r', [[ :e<CR> ]], opts)
      vim.api.nvim_set_keymap('n', '<leader>R', [[ :e!<CR> ]], opts)
    end,
  },

  -- lualine
  -- oryginal idea taken from
  -- https://github.com/Pasqat/my-turn/blob/c4cd1ab0c34e48b4daa054812c58e0c014d620d8/evil_lualine.lua
  {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    dependencies = {
      'folke/tokyonight.nvim',
      'vuki656/package-info.nvim',
    },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = ' '
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    config = function()
      vim.o.showmode = false
      vim.o.laststatus = vim.g.lualine_laststatus

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand('%:p:h')
          local gitdir = vim.fn.finddir('.git', filepath .. ';')
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      require('lualine').setup({
        options = {
          theme = 'onedark',
          disabled_filetypes = { 'fzf' },
          component_separators = '|',
          section_separators = { '', '' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        sections = {
          lualine_a = { { 'mode', upper = true } },
          lualine_b = {
            {
              'branch',
              icon = '',
              condition = conditions.check_git_workspace,
            },
            {
              'diff',
              symbols = {
                added = ' ',
                modified = ' ',
                removed = ' ',
              },
              condition = conditions.hide_in_width,
            },
          },
          lualine_c = {
            {
              'filename',
              file_status = true,
              condition = conditions.buffer_not_empty,
              color = { gui = 'bold' },
            },
            {
              function()
                local function format_file_size(file)
                  local size = vim.fn.getfsize(file)
                  if size <= 0 then
                    return ''
                  end
                  local sufixes = { 'b', 'k', 'm', 'g' }
                  local i = 1
                  while size > 1024 do
                    size = size / 1024
                    i = i + 1
                  end
                  return string.format('%.1f%s', size, sufixes[i])
                end
                local file = vim.fn.expand('%:p')
                if string.len(file) == 0 then
                  return ''
                end
                return format_file_size(file)
              end,
              condition = conditions.buffer_not_empty,
            },
          },
          lualine_x = {
            'encoding',
            'fileformat',
            { 'filetype', colored = true },
          },
          lualine_y = {
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              symbols = { error = ' ', warn = ' ', info = ' ' },
            },
            {
              function()
                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                local clients = vim.lsp.get_active_clients()
                if next(clients) == nil then
                  return
                end
                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                  end
                end
              end,
              icon = '  ',
            },
            {
              function()
                return require('package-info').get_status()
              end,
            },
          },
          lualine_z = {
            { 'progress', condition = conditions.hide_in_width },
            { 'location', condition = conditions.hide_in_width },
          },
        },
        extensions = {
          'fugitive',
          'fzf',
          'quickfix',
        },
      })
    end,
  },

  -- Active indent guide and indent text objects. When you're browsing
  -- code, this highlights the current level of indentation, and animates
  -- the highlighting.
  {
    'echasnovski/mini.indentscope',
    event = 'VimEnter',
    opts = {
      symbol = '│',
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- indent guides for Neovim
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      indent = {
        char = '┊',
        tab_char = '>',
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        injected_languages = true,
        priority = 1,
      },
      exclude = {
        filetypes = {
          'Trouble',
          'dashboard',
          'help',
          'lazy',
          'lazyterm',
          'man',
          'mason',
          'toggleterm',
          'trouble',
        },
      },
    },
    main = 'ibl',
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'mini',
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end,                 mode = "c",                 desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end,                                desc = "Dismiss All" },
      { "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,              expr = true,              desc = "Scroll Forward",  mode = { "i", "n", "s" } },
      { "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,              expr = true,              desc = "Scroll Backward", mode = { "i", "n", "s" } },
    },
  },

  { 'nvim-tree/nvim-web-devicons', lazy = true },
  { 'MunifTanjim/nui.nvim', lazy = true },
}
