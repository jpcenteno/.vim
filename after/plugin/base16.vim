if exists('g:lightline')
  let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

  let s:p.normal.left     = [ [ g:base16_cterm01, g:base16_cterm03 ], [ g:base16_cterm05, g:base16_cterm02 ] ]
  let s:p.insert.left     = [ [ g:base16_cterm00, g:base16_cterm0D ], [ g:base16_cterm05, g:base16_cterm02 ] ]
  let s:p.visual.left     = [ [ g:base16_cterm00, g:base16_cterm09 ], [ g:base16_cterm05, g:base16_cterm02 ] ]
  let s:p.replace.left    = [ [ g:base16_cterm00, g:base16_cterm08 ], [ g:base16_cterm05, g:base16_cterm02 ] ]
  let s:p.inactive.left   = [ [ g:base16_cterm02, g:base16_cterm00 ] ]

  let s:p.normal.middle   = [ [ g:base16_cterm07, g:base16_cterm01 ] ]
  let s:p.inactive.middle = [ [ g:base16_cterm01, g:base16_cterm00 ] ]

  let s:p.normal.right    = [ [ g:base16_cterm01, g:base16_cterm03 ], [ g:base16_cterm03, g:base16_cterm02 ] ]
  let s:p.inactive.right  = [ [ g:base16_cterm01, g:base16_cterm00 ] ]

  let s:p.normal.error    = [ [ g:base16_cterm07, g:base16_cterm08 ] ]
  let s:p.normal.warning  = [ [ g:base16_cterm07, g:base16_cterm09 ] ]

  let s:p.tabline.left    = [ [ g:base16_cterm05, g:base16_cterm02 ] ]
  let s:p.tabline.middle  = [ [ g:base16_cterm05, g:base16_cterm01 ] ]
  let s:p.tabline.right   = [ [ g:base16_cterm05, g:base16_cterm02 ] ]
  let s:p.tabline.tabsel  = [ [ g:base16_cterm02, g:base16_cterm0A ] ]

  let g:lightline#colorscheme#base16#palette = lightline#colorscheme#flatten(s:p)
endif

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
