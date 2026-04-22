return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install({
        'bash', 'dockerfile', 'elm', 'go', 'html', 'java',
        'javascript', 'json', 'lua', 'python', 'regex', 'scss',
        'toml', 'tsx', 'typescript', 'vim', 'vue', 'yaml',
      })

      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          if pcall(vim.treesitter.start) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      -- incremental selection via treesitter nodes
      local node_sel = nil
      local function select_node(node)
        local sr, sc, er, ec = node:range()
        -- exit visual first, then reselect charwise
        local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
        vim.cmd('normal! v')
        vim.api.nvim_win_set_cursor(0, { er + 1, ec > 0 and ec - 1 or 0 })
      end
      vim.keymap.set('n', '<C-space>', function()
        node_sel = vim.treesitter.get_node()
        if node_sel then select_node(node_sel) end
      end, { desc = 'Init treesitter selection' })
      vim.keymap.set('x', '<space>', function()
        if node_sel and node_sel:parent() then
          node_sel = node_sel:parent()
          select_node(node_sel)
        end
      end, { desc = 'Expand treesitter selection' })
      vim.keymap.set('x', '<bs>', function()
        if node_sel and node_sel:child(0) then
          node_sel = node_sel:child(0)
          select_node(node_sel)
        end
      end, { desc = 'Shrink treesitter selection' })
    end,
    dependencies = { 'hiphish/rainbow-delimiters.nvim', 'windwp/nvim-ts-autotag' },
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    enabled = true,
    opts = { mode = 'cursor', max_lines = 3 },
    keys = {
      {
        '<leader>ut',
        function()
          local tsc = require('treesitter-context')
          tsc.toggle()
        end,
        desc = 'Toggle Treesitter Context',
      },
    },
  },
}
