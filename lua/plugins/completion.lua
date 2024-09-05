local g, opt = vim.g, vim.opt
local cmp = require('cmp')
local lspkind = require('lspkind')

-- useful options
opt.inccommand = 'nosplit'
opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
opt.shortmess:append('c')

-- cmp setup

function formatter(entry, vim_item)
  vim_item.kind = lspkind.presets.default[vim_item.kind] .. ' ' .. vim_item.kind

  -- set a name for each source
  vim_item.menu = ({
    buffer = '[Buffer]',
    path = '[Path]',
    nvim_lsp = '[LSP]',
    nvim_lua = '[Lua]',
    calc = '[Calc]',
    emoji = '[Emoji]',
    ultisnips = '[UltiSnips]',
    cmp_tabnine = '[TabNine]',
  })[entry.source.name]

  return vim_item
end

cmp.setup({
  enabled = true,

  completion = {
    keyword_length = 2,
  },

  formatting = { format = formatter },

  preselect = cmp.PreselectMode.Item,

  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },

  window = {
    documentation = {
      border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
      winhighlight = 'NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder',
      maxwidth = math.floor(vim.o.columns * 0.5),
      maxheight = math.floor(vim.o.lines * 0.3),
    },
  },

  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },

  sources = {
    { name = 'nvim_lsp' },
    --{ name = "nvim_lua" },
    { name = 'buffer' },
    { name = 'tags' },
    { name = 'path' },
    { name = 'vsnip' },
  },
})
