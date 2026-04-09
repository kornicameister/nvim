vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = { current_line = true },
})

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

    -- Skip non-code buffers
    if vim.bo[bufnr].buftype ~= '' then
      client:stop(true)
      return
    end

    -- Extensions
    require('nvim-lightbulb').setup({ autocmd = { enabled = true } })

    -- Omnifunc
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Keymaps
    local function map(key, fn, desc)
      vim.keymap.set('n', key, fn, { buffer = bufnr, desc = desc })
    end

    if client.server_capabilities.renameProvider then
      map('<S-r>', vim.lsp.buf.rename, 'LSP: Rename')
    end
    if client.server_capabilities.hoverProvider then
      map('?', vim.lsp.buf.hover, 'LSP: Hover')
    end

    map('<S-f>', function() vim.lsp.buf.format({ async = true }) end, 'LSP: Format')

    -- Diagnostics navigation
    map('[d', function() vim.diagnostic.jump({ count = -1 }) end, 'Prev diagnostic')
    map(']d', function() vim.diagnostic.jump({ count = 1 }) end, 'Next diagnostic')

    -- Go to definition/implementation (via Telescope)
    local tb = require('telescope.builtin')
    map('gd', tb.lsp_definitions, 'LSP: Definition')
    map('gT', tb.lsp_type_definitions, 'LSP: Type definition')
    map('gi', tb.lsp_implementations, 'LSP: Implementation')
    map('gr', tb.lsp_references, 'LSP: References')

    -- Other
    map('<C-k>', vim.lsp.buf.signature_help, 'LSP: Signature help')
    map('<space>ca', vim.lsp.buf.code_action, 'LSP: Code action')
    map('<space>e', vim.diagnostic.open_float, 'Diagnostic: Float')
    map('<space>q', vim.diagnostic.setloclist, 'Diagnostic: Loclist')

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
    map('<C-n>', function() require('illuminate').goto_next_reference(true) end, 'Next reference')
    map('<C-p>', function() require('illuminate').goto_prev_reference(true) end, 'Prev reference')
  end,
})

-- Non-mason LSP servers
vim.lsp.enable('iam_legend')
vim.lsp.enable('ruff')
vim.lsp.enable('biome')
vim.lsp.enable('ty')
