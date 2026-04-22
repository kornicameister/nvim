return {
  {
    'calebfroese/mcpserver.nvim',
    dir = vim.fn.stdpath('data') .. '/lazy/mcpserver.nvim',
    config = function()
      -- MCP server starts automatically on VimEnter
      -- Socket path: /tmp/nvim-mcp-server-<pid>.sock
    end,
  },
}
