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
