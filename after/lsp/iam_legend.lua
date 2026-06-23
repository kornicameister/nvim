return {
  cmd = { 'node', '--experimental-strip-types', vim.fn.stdpath('data') .. '/lazy/iam-legend-lsp/src/server.ts', '--stdio' },
  filetypes = { 'yaml.cloudformation', 'json.cloudformation' },
  root_markers = { '.git' },
}
