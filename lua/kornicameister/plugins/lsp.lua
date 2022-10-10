local lsp_config = require("lspconfig")
local configs = require("lspconfig.configs")

local lsp_status = require("lsp-status")
local lsp_installer = require("nvim-lsp-installer")
local efm_config = require("kornicameister.plugins.efm")

lsp_status.register_progress()
require("lspkind").init({
  preset = "codicons",
})
require("lspfuzzy").setup({
  methods = "all",
  fzf_action = { ["ctrl-v"] = "vsplit", ["ctrl-x"] = "split" },
})

local on_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local on_attach = function(client, bufnr)
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

----
-- reference implementation of this logic
-- https://gitlab.com/Iron_E/dotfiles/-/blob/master/.config/nvim/lua/plugin/lspconfig.lua
----

-- TODO how to make them installed corectly
-- and how those moved up to pass additional properties too
-- in general, there is a problem with either npm binaries over nodenv
-- with python I believe pipx installation method is downright correct

local function setup_servers()
  local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

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

  local servers = {
    ["bashls"] = {
      ["filetypes"] = { "sh", "zsh" },
    },
    ["cmake"] = {
      ["filetypes"] = { "cmake", "make" },
    },
    ["dockerls"] = { filetypes = { "dockerfile" } },
    ["elmls"] = { filetypes = { "elm" } },
    ["intelephense"] = { filetypes = { "php" } },
    "html",
    "cssls",
    "jsonls",
    "pylsp",
    "texlab",
    "tsserver",
    "vimls",
    "vuels",
    "yamlls",
    ["efm"] = {
      cmd = { "efm-langserver" },
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
    },
    ["sumneko_lua"] = {
      cmd = { "lua-language-server" },
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
    },
  }
  for key, value in pairs(servers) do
    local has_config = type(key) == "string"
    local config = has_config and value or {}
    local name = has_config and key or value

    local server_available, requested_server = lsp_installer.get_server(name)
    if server_available then
      if not requested_server:is_installed() then
        print("LSP " .. name .. " will be installed")
        requested_server:install()
      end
    end

    if name ~= "efm" then
      config.on_attach = on_attach
      config.on_init = on_init
      config.capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities, config.capabilities or {})

      if lsp_status.extensions[name] ~= nil then
        config.handlers = lsp_status.extensions[name].setup()
      end
    end

    lsp_config[name].setup(config)
  end
end

setup_servers()
