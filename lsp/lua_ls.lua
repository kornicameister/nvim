return {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      completion = { keywordSnippet = 'Both' },
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      workspace = {
        library = { vim.fn.expand('$VIMRUNTIME/lua') },
      },
    },
  },
}
