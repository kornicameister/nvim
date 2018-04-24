" Copyright 2018 kornicameister

" leader
let mapleader=','

" general settings for editor
set nocompatible
syntax on
set encoding=utf-8
set smartindent

" no temp or backup files
set noswapfile
set nobackup
set nowritebackup

" set proper tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" backspace fix
set backspace=indent,eol,start
fixdel

" Show linenumbers
set number
set ruler

" make whitespaces, tabs visible
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
highlight BadWhitespace ctermbg=red guibg=red
set list

" always display status line
set laststatus=2

" enable filetypes plugins
filetype plugin indent on

""" editor settings

" vim theme settings
hi Normal ctermbg=none
colorscheme PaperColor
set background=light

" tabs keybindings
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-left> :tabp<cr>
map <C-right> :tabn<cr>

" splitting windows settings
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Reload changes to .vimrc automatically
autocmd BufWritePost ~/.vimrc source ~/.vimrc
