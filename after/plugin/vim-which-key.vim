" ╔════════════════════════════════════════════════════════════════════════╗
" ║ General settings                                                       ║
" ╚════════════════════════════════════════════════════════════════════════╝

let g:which_key_timeout = 0

let g:which_key_map = {}

" ------------------------------------------------------------------------------
"  [b] Buffers mappings:
" ------------------------------------------------------------------------------

let g:which_key_map["b"] = { 'name' : '+buffers' }
let g:which_key_map['b']['n'] = [ ':bn',      'Next Buffer' ]
let g:which_key_map['b']['p'] = [ ':bp',      'Prev Buffer' ]
let g:which_key_map['b']['d'] = [ ':bp|bd#',  'Delete Buffer' ] " See (1)
let g:which_key_map['b']['b'] = [ ':Telescope buffers', 'Search buffers' ]

" (1) I'm using this command instead of `:bd` to prevent the current window
" from being closed. There is a known bug for `:bp|bd#` in which it will close
" any other window that's currently displaying the target buffer, but it works
" well on most cases.

" ------------------------------------------------------------------------------
"  [f] Filesystem mappings:
" ------------------------------------------------------------------------------

let g:which_key_map['f'] = { 'name' : '+filesystem' }
let g:which_key_map['f']['t'] = [ ':NERDTreeToggle', 'NerdTree' ]
let g:which_key_map['f']['f'] = [ ':Telescope find_files', 'Search files' ]
let g:which_key_map['f']['g'] = [ ':Telescope git_files', 'Search git files' ]
let g:which_key_map['f']['r'] = [ ':Telescope live_grep', 'Ripgrep' ]

" ------------------------------------------------------------------------------
"  [l] LSP mappings:
" ------------------------------------------------------------------------------

let g:which_key_map['l'] = { 'name' : '+LSP' }

" Failing to map this beforehand resulted in a weird message error.
nnoremap <silent> <leader>ld :Trouble<CR>
let g:which_key_map['l']['d'] = [ ':TroubleToggle', 'Diagnostics' ]

" ╔════════════════════════════════════════════════════════════════════════╗
" ║ [Z] Zettelkasten mappings                                              ║
" ╚════════════════════════════════════════════════════════════════════════╝

let g:which_key_map['n'] = { 'name': '+Notes' }
let g:which_key_map['n']['o'] = [ ':KastenTelescopeOpen', 'Open' ]
let g:which_key_map['n']['n'] = [ ':call kasten#notes#new()', 'New' ]
let g:which_key_map['n']['s'] = [ ':ObsidianSearch', 'Search' ]

" ------------------------------------------------------------------------------
"  Register the mapings dictionary
" ------------------------------------------------------------------------------

call which_key#register('<Space>', "g:which_key_map")

let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
