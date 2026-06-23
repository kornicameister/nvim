return {
  cmd = { 'uvx', 'ruff', 'server' },
  filetypes = { 'python' },
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, { 'pyproject.toml', 'ruff.toml', '.ruff.toml' })
    if root then on_dir(root) end
  end,
  capabilities = {
    general = {
      positionEncodings = { 'utf-16' },
    },
  },
}
