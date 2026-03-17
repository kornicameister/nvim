return {
  root_dir = function(bufnr, on_dir)
    local uv_root = vim.fs.root(bufnr, 'uv.lock')
    on_dir(uv_root or vim.fs.root(bufnr, { 'pyproject.toml', 'setup.py', '.git' }))
  end,
  settings = {
    pylsp = {
      plugins = {
        rope_autoimport = { enabled = true },
        rope_completion = { enabled = true },
      },
    },
  },
}
