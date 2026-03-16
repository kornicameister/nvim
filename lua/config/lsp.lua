local lsp_status = require('lsp-status')

require('neodev').setup({})
require('mason').setup({
  ui = {
    icons = {
      package_installed = '✓',
    },
  },
})

require('mason-lspconfig').setup({
  ensure_installed = {
    'awk_ls',
    'basedpyright',
    'bashls',
    'biome',
    'cmake',
    'cssls',
    'dockerls',
    'elmls',
    'eslint',
    'html',
    'jsonls',
    'lua_ls',
    'marksman',
    'pylsp',
    'sqlls',
    'texlab',
    'vacuum',
    'vimls',
    'vtsls',
    'yamlls',
  },
  automatic_enable = true,
})

-- Capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
capabilities.textDocument.codeLens = {
  dynamicRegistration = false,
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

-- On attach function
local on_attach = function(client, bufnr)
  -- Extensions
  require('folding').on_attach()
  require('illuminate').on_attach(client)
  lsp_status.on_attach(client)

  -- Omnifunc
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Document highlight
  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup('lsp_document_highlight_' .. bufnr, {})
    vim.api.nvim_create_autocmd({ 'CursorHold' }, {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  -- Keymaps
  local opts = { noremap = true, silent = true, buffer = bufnr }

  if client.server_capabilities.renameProvider then
    vim.keymap.set('n', '<S-r>', vim.lsp.buf.rename, opts)
  end
  if client.server_capabilities.hoverProvider then
    vim.keymap.set('n', '?', vim.lsp.buf.hover, opts)
  end

  vim.keymap.set('n', '<S-f>', function()
    vim.lsp.buf.format({ async = true })
  end, opts)

  -- Diagnostics navigation
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

  -- Go to definition/implementation
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

  -- Other
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- Illuminate
  vim.keymap.set('n', '<C-n>', function()
    require('illuminate').goto_next_reference({ wrap = true })
  end, opts)
  vim.keymap.set('n', '<C-p>', function()
    require('illuminate').goto_prev_reference({ wrap = true })
  end, opts)
end

-- Default config for all servers
vim.lsp.config('*', {
  capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities),
  on_attach = on_attach,
})

lsp_status.register_progress()
require('lspkind').init({
  preset = 'codicons',
})
require('lspfuzzy').setup({
  methods = 'all',
  fzf_action = { ['ctrl-v'] = 'vsplit', ['ctrl-x'] = 'split' },
})
