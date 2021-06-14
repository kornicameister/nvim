if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal textwidth=79

setlocal autoindent
setlocal smartindent

setlocal fileformat=unix

let b:comment_leader = '//'

match BadWhitespace /^\t\+/
match BadWhitespace /\s\+$/
