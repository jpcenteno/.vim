if empty(globpath(&rtp, 'colors/dim.vim'))
  finish
endif

function! CustomizeDim() abort
  highlight SignColumn ctermbg=NONE

  highlight SpellBad   ctermbg=NONE ctermfg=NONE cterm=underline
  highlight SpellRare  ctermbg=NONE ctermfg=NONE cterm=underline
  highlight SpellLocal ctermbg=NONE ctermfg=NONE cterm=underline
endfunction

augroup CustomizeDim
    autocmd!
    autocmd ColorScheme dim call CustomizeDim()
augroup END

if get(g:, 'colors_name', 'default') == 'dim'
    call CustomizeDim()
endif
