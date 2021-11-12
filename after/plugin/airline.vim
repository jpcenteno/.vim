" I found that powerline were problematic because they might not be set on the
" terminal emulator. Also, I found them distracting, so I prefer not to use
" them.
let g:airline_powerline_fonts = 0

" Some other cool symbols that could be used:    
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

" Don't show encoding data.
let g:airline_section_y = ""

" Use simple coordinates to indicate cursor possition.
let g:airline_section_z = airline#section#create(['%l', ':', '%v'])

" Use shorter symbols to display the current mode.
let g:airline_mode_map = {
  \ '__'     : '-',
  \ 'c'      : 'C',
  \ 'i'      : 'I',
  \ 'ic'     : 'I',
  \ 'ix'     : 'I',
  \ 'n'      : 'N',
  \ 'multi'  : 'M',
  \ 'ni'     : 'N',
  \ 'no'     : 'N',
  \ 'R'      : 'R',
  \ 'Rv'     : 'R',
  \ 's'      : 'S',
  \ 'S'      : 'S',
  \ 't'      : 'T',
  \ 'v'      : 'V',
  \ 'V'      : 'V',
  \ }

