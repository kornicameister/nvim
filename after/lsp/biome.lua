return {
  cmd = { 'npx', '@biomejs/biome', 'lsp-proxy' },
  filetypes = {
    'typescript',
    'javascript',
    'typescriptreact',
    'javascriptreact',
    'markdown',
    'html',
    'css',
    'less',
    'sass',
    'scss',
    'json',
  },
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, { 'biome.json', 'biome.jsonc', 'package.json', '.git' })
    if root then on_dir(root) end
  end,
  workspace_required = false,
}
