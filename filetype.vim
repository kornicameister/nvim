scriptencoding utf-8

set fileformats=unix,dos,mac

augroup git_ft_config
  au!
  au BufNewFile,BufRead gitconfig setlocal ft=gitconfig nolist nospell ts=4 sw=4 noet
  au BufNewFile,BufRead .gitconfig* setlocal ft=gitconfig nolist nospell ts=4 sw=4 noet
  au FileType gitcommit setlocal nospell
augroup END

augroup sh_ft_settings
  au!
  au BufNewFile,BufRead *.sh setlocal ai et ts=2 sw=2 sts=2
augroup END

augroup vim_ft_settings
  au!
  au BufNewFile,BufRead *.vim setlocal ai et ts=2 sw=2 sts=2
augroup END

augroup text_ft_settings
  au!
  au BufNewFile,BufRead *.txt setlocal et ts=4 sw=4
augroup END

augroup cpp_ft_settings
  au!
  au BufNewFile,BufRead *.cpp setlocal et ts=2 sw=2
  au BufNewFile,BufRead *.hpp setlocal et ts=2 sw=2
augroup END

augroup json_ft_settings
  au!
  au FileType json setlocal foldmethod=syntax
  au BufNewFile,BufRead *.json setlocal et ts=2 sw=2
augroup END

augroup asciidoc_ft_settings
  au!
  au FileType asciidoc setlocal spell
augroup END

augroup ssh_config_settings
  au!

  au BufNewFile,BufRead *ssh/config set
    \ nospell
    \ encoding=utf-8
    \ ts=2
    \ sw=2
    \ filetype=sshconfig
  au BufNewFile,BufRead *ssh/config.d/* set
    \ nospell
    \ encoding=utf-8
    \ ts=2
    \ sw=2
    \ filetype=sshconfig

augroup END
