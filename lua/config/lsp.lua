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
    'bashls',
    'cmake',
    'cssls',
    'dockerls',
    'elmls',
    'eslint',
    'html',
    'jsonls',
    'lua_ls',
    'marksman',
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
local capabilities = require('blink.cmp').get_lsp_capabilities({
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
    codeLens = {
      dynamicRegistration = false,
    },
  },
})

-- Default config for all servers
vim.lsp.config('*', {
  capabilities = capabilities,
})

-- On attach (replaces old on_attach — not supported in vim.lsp.config)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    if not client then return end

    -- Extensions
    require('nvim-lightbulb').setup({ autocmd = { enabled = true } })

    -- Omnifunc
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

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
    vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, opts)

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

    -- LSP features (auto-enable + toggle keymaps)
    if client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
    vim.keymap.set('n', '<leader>ih', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
    end, { buffer = bufnr, desc = 'Toggle inlay hints' })

    if client:supports_method('textDocument/codeLens') then
      vim.lsp.codelens.enable(true, { bufnr = bufnr })
    end

    if client:supports_method('textDocument/inlineCompletion') then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end

    -- Illuminate
    vim.keymap.set('n', '<C-n>', function()
      require('illuminate').goto_next_reference(true)
    end, opts)
    vim.keymap.set('n', '<C-p>', function()
      require('illuminate').goto_prev_reference(true)
    end, opts)
  end,
})

-- Non-mason LSP servers
vim.lsp.enable('iam_legend')
vim.lsp.enable('ruff')
vim.lsp.enable('biome')
vim.lsp.enable('ty')
