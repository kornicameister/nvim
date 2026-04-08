return {
  filetypes = { 'python' },
  cmd = { 'uvx', 'ty', 'server' },
  root_dir = function(bufnr, on_dir)
    local uv_root = vim.fs.root(bufnr, 'uv.lock')
    on_dir(uv_root or vim.fs.root(bufnr, { 'pyproject.toml', 'setup.py', '.git' }))
  end,
  before_init = function(_, config)
    local venv = vim.fs.joinpath(config.root_dir, '.venv')
    config.settings = {
      ty = {
        showSyntaxErrors = false,
        diagnosticMode = 'workspace',
        completions = { autoImport = true },
        inlayHints = { variableTypes = true, callArgumentNames = true },
        configuration = {
          environment = vim.uv.fs_stat(venv) and { python = venv } or nil,
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
