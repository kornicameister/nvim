if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

setlocal ts=2 sts=2 sw=2 tw=79
setlocal expandtab
setlocal autoindent
setlocal smartindent
setlocal fileformat=unix

let b:comment_leader = '//'

match BadWhitespace /^\t\+/
match BadWhitespace /\s\+$/
