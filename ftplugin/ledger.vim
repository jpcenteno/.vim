" I keep my ledger in Spanish.
setlocal spell spelllang=es

" Align buffer before saving.
au BufWritePre <buffer> :LedgerAlignBuffer

let g:ledger_align_at = 60
let g:ledger_align_commodity = 0
let g:ledger_default_commodity = ''
let g:ledger_date_format = '%Y-%m-%d'
