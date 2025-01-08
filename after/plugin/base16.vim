function! s:base16_colorscheme_enhancements() abort

endfunction

augroup Base16ColorschemeEnhancements
  autocmd!
  autocmd Colorscheme base16-default-* call s:base16_colorscheme_enhancements()
augroup END

" `g:colors_name` can be undefined if `colorscheme ...` has not been called
" before this script.
let s:colors_name = get(g:, 'colors_name', 'default')

if s:colors_name ==# 'base16-default-light' || s:colors_name ==# 'base16-default-dark'
  call s:base16_colorscheme_enhancements()
endif
