let g:which_key_map = {}

let g:which_key_map["b"] = { 'name' : '+buffer' }
let g:which_key_map['b']['n'] = [ ':bn',      'Next Buffer' ]
let g:which_key_map['b']['p'] = [ ':bp',      'Prev Buffer' ]
let g:which_key_map['b']['d'] = [ ':bd',      'Delete Buffer' ]
let g:which_key_map['b']['b'] = [ ':Buffers', 'Select Buffer' ] " Requires `fzf` plugin.

call which_key#register('<Space>', "g:which_key_map")

let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

