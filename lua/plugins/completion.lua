---@module 'blink.cmp'
---@type blink.cmp.Config
return {
  keymap = {
    preset = 'enter',
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
    ['<C-Space>'] = { 'show' },
  },

  appearance = { nerd_font_variant = 'mono' },

  completion = {
    keyword = { range = 'prefix' },
    documentation = { auto_show = true },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    per_filetype = {
      lua = { inherit_defaults = true, 'lazydev' },
      python = { 'lsp', 'path', 'snippets' },
    },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
    },
  },

  fuzzy = { implementation = 'prefer_rust_with_warning' },
}
