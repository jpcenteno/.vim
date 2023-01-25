let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

" This hack is necessary because we can't pass a function call (`join`) to the
" method `autocmd` pattern.
execute 'autocmd FileType ' . join(g:lisp_fts, ',') . ' RainbowParentheses'
