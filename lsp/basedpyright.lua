return {
  root_dir = function(bufnr, default)
    -- For uv workspaces: use the workspace root (has uv.lock + real .venv)
    -- instead of sub-package root where basedpyright would land by default
    local uv_root = vim.fs.root(bufnr, 'uv.lock')
    return uv_root or default()
  end,
  settings = {
    basedPyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
        typeCheckingMode = 'standard',
      },
    },
  },
}
