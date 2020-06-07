let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'mode_map': {
    \   'n':      'N',
    \   'i':      'I',
    \   'R':      'R',
    \   'v':      'V',
    \   'V':      'V ▬ ',
    \   "\<C-v>": 'V ▢ ',
    \   'c':      'C',
    \   's':      'S',
    \   'S':      'SL',
    \   "\<C-s>": 'SB',
    \   't':      'T',
    \ },
    \ }

set laststatus=2 " Enable Lightline
set noshowmode   " Hide mode from the statusline

function! s:set_lightline_colorscheme(name) abort
  let g:lightline.colorscheme = a:name
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

call s:set_lightline_colorscheme('solarized')
