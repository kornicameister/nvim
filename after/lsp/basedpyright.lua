return {
  root_dir = function(bufnr, on_dir)
    local uv_root = vim.fs.root(bufnr, 'uv.lock')
    on_dir(uv_root or vim.fs.root(bufnr, { 'pyproject.toml', 'setup.py', '.git' }))
  end,
  before_init = function(_, config)
    local venv = vim.fs.joinpath(config.root_dir, '.venv')
    if vim.uv.fs_stat(venv) then
      config.settings.python = { pythonPath = vim.fs.joinpath(venv, 'bin', 'python') }
    end
  end,
  filetypes = { 'python' },
  settings = {
    basedpyright = {
      analysis = {
        autoImportCompletions = true,
        typeCheckingMode = 'standard',
      },
    },
  },
}
