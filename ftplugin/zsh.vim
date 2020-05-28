" Inherit config from `sh`
source <sfile>:h/sh.vim
" <sfile>   => path for this file.
" <sfile>:h => Only the head.

" Enable Shellcheck (1) via ALE
let g:ale_linters.zsh = ['shellcheck']
