" Hide the `-- MODE --` message from the bottom of the screen as it's
" redundant with LightLine.
set noshowmode

let g:lightline = {}

" ------------------------------------------------------------------------------
" Minimal status line:
" ------------------------------------------------------------------------------

" Use just one character to display the current mode:
let g:lightline['mode_map'] = {}
let g:lightline['mode_map']['n'] = 'N'
let g:lightline['mode_map']['i'] = 'I'
let g:lightline['mode_map']['R'] = 'R'
let g:lightline['mode_map']['v'] = 'V'
let g:lightline['mode_map']['V'] = 'VL'
let g:lightline['mode_map']["\<C-v>"] = 'VB'
let g:lightline['mode_map']['c'] = 'C'
let g:lightline['mode_map']['s'] = 'S'
let g:lightline['mode_map']['S'] = 'SL'
let g:lightline['mode_map']["\<C-s>"] = 'SB'
let g:lightline['mode_map']['t'] = 'T'

" Simplify the line information displayed:
let s:left_status_components = [['mode', 'paste'], ['readonly', 'filetype', 'relativepath', 'modified']]
let s:right_status_components = [['lineinfo']]

let g:lightline.active = {}
let g:lightline.active.left = s:left_status_components
let g:lightline.active.right = s:right_status_components

let g:lightline.inactive = {}
let g:lightline.inactive.left = s:left_status_components
let g:lightline.inactive.right = s:right_status_components

" Don't use separators:
let g:lightline.subseparator = { 'left': '', 'right': '' }


" ------------------------------------------------------------------------------
" Display file type icons:
" ------------------------------------------------------------------------------

function! MyFiletype()
  return strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

let g:lightline.component_function = {}
let g:lightline.component_function['filetype'] = 'MyFiletype'
let g:lightline.component_function['fileformat'] = 'MyFileformat'

" ------------------------------------------------------------------------------
" Theme:
" ------------------------------------------------------------------------------

let g:lightline.colorscheme = 'dim'
