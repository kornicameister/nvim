--- built on top of
--- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local function augroup(name)
  return vim.api.nvim_create_augroup(
    'kornicameister_' .. name,
    { clear = true }
  )
end

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+://') then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- trim trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup('trimwhitespaces'),
  command = [[%s/\s\+$//e]],
})

-- toggle relative numbers based on focus/mode
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
  group = augroup('numbertoggle'),
  command = 'set relativenumber',
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
  group = augroup('numbertoggle'),
  command = 'set norelativenumber',
})

-- auto save on focus lost
vim.api.nvim_create_autocmd('FocusLost', {
  group = augroup('autosave'),
  command = 'silent! wa',
})

-- open help in vertical split
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('help_vertical'),
  pattern = 'help',
  command = 'wincmd L',
})

-- terminal defaults
vim.api.nvim_create_autocmd('TermOpen', {
  group = augroup('terminal'),
  callback = function()
    vim.opt_local.number = false
    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { buffer = true })
  end,
})

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('yank_highlight'),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- restore cursor position on file open
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('restore_cursor'),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})
