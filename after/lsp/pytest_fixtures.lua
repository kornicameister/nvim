return {
  cmd = { 'pytest-fixtures-lsp' },
  filetypes = { 'python' },
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, { 'uv.lock', '.venv', 'venv', 'pyproject.toml', 'setup.py' })
    if root then on_dir(root) end
  end,
  on_attach = function(client, bufnr)
    local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':t')
    if not (name:match('^test_.*%.py$') or name:match('_test%.py$') or name == 'conftest.py') then
      vim.lsp.buf_detach_client(bufnr, client.id)
    end
  end,
}
