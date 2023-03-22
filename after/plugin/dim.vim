if empty(globpath(&rtp, 'colors/dim.vim'))
  finish
endif

function! CustomizeDimLight() abort
  highlight DimFzfBg   ctermbg=7
endfunction

function! CustomizeDimDark() abort
  highlight DimFzfBg   ctermbg=0
endfunction

function! CustomizeDim() abort
  highlight SignColumn ctermbg=NONE

  highlight SpellBad   ctermbg=NONE ctermfg=NONE cterm=underline
  highlight SpellRare  ctermbg=NONE ctermfg=NONE cterm=underline
  highlight SpellLocal ctermbg=NONE ctermfg=NONE cterm=underline

  if &background == "light"
    call CustomizeDimLight()
  else
    call CustomizeDimDark()
  endif
endfunction

augroup CustomizeDim
    autocmd!
    autocmd ColorScheme dim call CustomizeDim()
augroup END

if get(g:, 'colors_name', 'default') == 'dim'
    call CustomizeDim()
endif
