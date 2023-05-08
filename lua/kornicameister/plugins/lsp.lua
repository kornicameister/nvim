local lsp_config = require("lspconfig")
local lsp_status = require("lsp-status")
local efm_config = require("kornicameister.plugins.efm")

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
    },
  },
})
-- commented sections are not LSP servers
-- how do I install them?
require("mason-lspconfig").setup({
  ensure_installed = {
    "awk_ls",
    "bashls",
    "cmake",
    "cssls",
    "dockerls",
    "efm",
    "elmls",
    -- "hadolint",
    "html",
    "jsonls",
    "lua_ls",
    "marksman",
    "pylsp",
    -- "shellcheck",
    -- "shfmt",
    "sqlls",
    "texlab",
    "tsserver",
    "vimls",
    "vuels",
    "yamlls",
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.codeLens = {
  dynamicRegistration = false,
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

require("mason-lspconfig").setup_handlers({
  function(server_name) -- default handler (optional)
    local config = {}

    config.on_attach = function(client, bufnr)
      local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
      end
      local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
      end

      -- prepare extensions
      require("folding").on_attach(client)
      require("illuminate").on_attach(client)
      lsp_status.on_attach(client)

      --Enable completion triggered by <c-x><c-o>
      buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

      -- Conditional capabilities
      -- ref: https://github.com/tjdevries/config_manager/blob/0ebe4c3232b61674aad0e4708228797b681fa2a7/xdg_config/nvim/lua/tj/lsp/init.lua#L100
      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec(
          [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]],
          false
        )
      end

      -- Mappings.
      local opts = { noremap = true, silent = true }

      -- general
      if client.server_capabilities.renameProvider then
        buf_set_keymap("n", "<S-r>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      end
      if client.server_capabilities.hoverProvider then
        buf_set_keymap("n", "?", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
      end
      if client.server_capabilities.documentFormattingProvider then
        if vim.tbl_contains(vim.tbl_keys(efm_config), client.name) then
          print("Using efm instead of " .. client.name .. " for formatting")
          client.server_capabilities.documentFormattingProvider = false
        end
        buf_set_keymap("n", "<S-f>", "<cmd>lua vim.lsp.buf.format({async = true}))<CR>", opts)
        vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format({async = true})")
      end

      -- issues navigation
      buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
      buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

      -- definition/implementation navigation
      buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
      buf_set_keymap("n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
      buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

      -- those are not yet ready
      buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
      buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
      buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

      -- illuminate
      buf_set_keymap("n", "<C-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', opts)
      buf_set_keymap("n", "<C-p>", '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', opts)
    end
    config.on_init = function(client)
      client.config.flags = client.config.flags or {}
      client.config.flags.allow_incremental_sync = true
    end
    config.capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities, config.capabilities or {})

    if lsp_status.extensions[server_name] ~= nil then
      config.handlers = lsp_status.extensions[server_name].setup()
    end

    require("lspconfig")[server_name].setup(config)
  end,
  ["efm"] = function()
    require("lspconfig")["efm"].setup({
      init_options = { documentFormatting = true, codeAction = true },
      root_dir = lsp_config.util.root_pattern({
        ".git/",
        "requirements.txt",
        "package.json",
        "setup.cfg",
        vim.fn.getcwd(),
      }),
      filetypes = vim.tbl_keys(efm_config),
      settings = {
        rootMarkers = { ".git/" },
        languages = efm_config,
      },
    })
  end,
  ["lua_ls"] = function()
    require("lspconfig")["lua_ls"].setup({
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          completion = { keywordSnippet = "Both" },
          runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
          workspace = {
            library = vim.list_extend({ [vim.fn.expand("$VIMRUNTIME/lua")] = true }, {}),
          },
        },
      },
    })
  end,
})

lsp_status.register_progress()
require("lspkind").init({
  preset = "codicons",
})
require("lspfuzzy").setup({
  methods = "all",
  fzf_action = { ["ctrl-v"] = "vsplit", ["ctrl-x"] = "split" },
})
