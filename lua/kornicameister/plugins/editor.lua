return {
  {
    'nvim-pack/nvim-spectre',
    build = false,
    cmd = 'Spectre',
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

  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    keys = {
      {
        '<leader>fe',
        function()
          require('neo-tree.command').execute({ toggle = true })
        end,
        desc = 'Explorer NeoTree (Root Dir)',
      },
      {
        '<leader>fE',
        function()
          require('neo-tree.command').execute({
            toggle = true,
            dir = vim.uv.cwd(),
          })
        end,
        desc = 'Explorer NeoTree (cwd)',
      },
      {
        '<leader>e',
        '<leader>fe',
        desc = 'Explorer NeoTree (Root Dir)',
        remap = true,
      },
      {
        '<leader>E',
        '<leader>fE',
        desc = 'Explorer NeoTree (cwd)',
        remap = true,
      },
      {
        '<leader>ge',
        function()
          require('neo-tree.command').execute({
            source = 'git_status',
            toggle = true,
          })
        end,
        desc = 'Git Explorer',
      },
      {
        '<leader>be',
        function()
          require('neo-tree.command').execute({
            source = 'buffers',
            toggle = true,
          })
        end,
        desc = 'Buffer Explorer',
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      if vim.fn.argc(-1) == 1 then
        local stat = vim.uv.fs_stat(vim.fn.argv(0))
        if stat and stat.type == 'directory' then
          require('neo-tree')
        end
      end
    end,
    opts = {
      sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
      open_files_do_not_replace_types = {
        'terminal',
        'Trouble',
        'trouble',
        'qf',
        'Outline',
      },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ['<space>'] = 'none',
          ['Y'] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg('+', path, 'c')
            end,
            desc = 'Copy Path to Clipboard',
          },
          ['O'] = {
            function(state)
              require('lazy.util').open(
                state.tree:get_node().path,
                { system = true }
              )
            end,
            desc = 'Open with System Application',
          },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
      },
    },
    config = function(_, opts)
      require('neo-tree').setup(opts)
      vim.api.nvim_create_autocmd('TermClose', {
        pattern = '*lazygit',
        callback = function()
          if package.loaded['neo-tree.sources.git_status'] then
            require('neo-tree.sources.git_status').refresh()
          end
        end,
      })
    end,
  },

  {
    'andythigpen/nvim-coverage',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {
        '<leader>;',
        function()
          require('coverage').load(true)
          require('coverage').toggle()
        end,
        desc = 'Toggle coverage',
      },
      {
        '<leader>;;',
        '<cmd>CoverageSummary<cr>',
        desc = 'Shows coverage summary',
      },
    },
    config = function()
      require('coverage').setup()
    end,
  },

  {
    'folke/trouble.nvim',
    branch = 'main',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {
        '<leader>xx',
        '<cmd>TroubleToggle document_diagnostics<cr>',
        desc = 'Document Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>TroubleToggle workspace_diagnostics<cr>',
        desc = 'Workspace Diagnostics (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>TroubleToggle loclist<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>TroubleToggle quickfix<cr>',
        desc = 'Quickfix List (Trouble)',
      },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').previous({ skip_groups = true, jump = true })
          else
            local _, err = pcall(vim.cmd.cprev)
            if err then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Previous Trouble/Quickfix Item',
      },
      {
        ']q',
        function()
          if require('trouble').is_open() then
            require('trouble').next({ skip_groups = true, jump = true })
          else
            local _, err = pcall(vim.cmd.cnext)
            if err then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Next Trouble/Quickfix Item',
      },
    },
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = {
      use_diagnostic_signs = true,
      position = 'bottom',
      auto_preview = true,
      auto_fold = true,
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('kornicameister.plugins.telescope')
    end,
    dependencies = {
      'gbrlsnchs/telescope-lsp-handlers.nvim',
      'jvgrootveld/telescope-zoxide',
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'tsakirist/telescope-lazy.nvim',
      'vuki656/package-info.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
  },

  {
    'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      require('package-info').setup({
        icons = {
          style = {
            up_to_date = '|  ',
            outdated = '|  ',
          },
        },
        colors = {
          up_to_date = '#00FF00',
          outdated = '#D19A66',
        },
      })
    end,
  },
}
