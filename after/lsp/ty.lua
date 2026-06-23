local venv_util = require('utils.python-venv')

return {
  filetypes = { 'python' },
  cmd = { 'uvx', 'ty', 'server' },
  root_dir = function(bufnr, on_dir)
    local uv_root = vim.fs.root(bufnr, 'uv.lock')
    on_dir(uv_root or vim.fs.root(bufnr, { 'pyproject.toml', 'setup.py', '.git' }))
  end,
  before_init = function(_, config)
    local venv = venv_util.find_venv(config.root_dir)
    config.settings = {
      ty = {
        showSyntaxErrors = false,
        diagnosticMode = 'workspace',
        completions = { autoImport = true },
        inlayHints = { variableTypes = true, callArgumentNames = true },
        configuration = {
          environment = venv and { python = venv } or nil,
          rules = {
            ['possibly-unresolved-reference'] = 'warn',
            ['possibly-missing-attribute'] = 'warn',
            ['division-by-zero'] = 'warn',
            ['deprecated'] = 'ignore',
            ['empty-body'] = 'ignore',
          },
        },
      },
    }
  end,
}
