let g:which_key_map = {}

" ------------------------------------------------------------------------------
"  [b] Buffers mappings:
" ------------------------------------------------------------------------------

let g:which_key_map["b"] = { 'name' : '+buffers' }
let g:which_key_map['b']['n'] = [ ':bn',      'Next Buffer' ]
let g:which_key_map['b']['p'] = [ ':bp',      'Prev Buffer' ]
let g:which_key_map['b']['d'] = [ ':bd',      'Delete Buffer' ]
let g:which_key_map['b']['b'] = [ ':Buffers', 'Select Buffer' ] " Requires `fzf` plugin.

" ------------------------------------------------------------------------------
"  [f] Filesystem mappings:
" ------------------------------------------------------------------------------

let g:which_key_map['f'] = { 'name' : '+filesystem' }
let g:which_key_map['f']['t'] = [ ':NERDTreeToggle', 'NerdTree' ]
let g:which_key_map['f']['f'] = [ ':Files', 'fzf all files' ] " Requires `fzf` plugin.
let g:which_key_map['f']['g'] = [ ':GFiles', 'fzf git files' ] " Requires `fzf` plugin.
let g:which_key_map['f']['r'] = [ ':Rg', 'fzf+rg results' ] " Requires `fzf` plugin.

" ------------------------------------------------------------------------------
"  [l] LSP mappings:
" ------------------------------------------------------------------------------

let g:which_key_map['l'] = { 'name' : '+LSP' }

" Failing to map this beforehand resulted in a weird message error.
nnoremap <silent> <leader>ld :TroubleToggle<CR>
let g:which_key_map['l']['d'] = [ ':TroubleToggle', 'Diagnostics' ]

" ------------------------------------------------------------------------------
"  Register the mapings dictionary
" ------------------------------------------------------------------------------

call which_key#register('<Space>', "g:which_key_map")

let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

