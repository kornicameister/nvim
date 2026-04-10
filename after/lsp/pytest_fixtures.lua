return {
  cmd = { 'pytest-fixtures-lsp' },
  filetypes = { 'python' },
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, { 'uv.lock', '.venv', 'venv', 'pyproject.toml', 'setup.py' })
    if root then on_dir(root) end
  end,
}
