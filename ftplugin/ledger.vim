setlocal nospell

" Align buffer before saving.
" au BufWritePre <buffer> :LedgerAlignBuffer

" Jump to the end of file
au BufWinEnter <buffer> normal G$

let b:is_hledger = v:false
" let g:ledger_align_at = 60
" let g:ledger_align_commodity = 0
" let g:ledger_default_commodity = ''
let g:ledger_date_format = '%Y-%m-%d'
