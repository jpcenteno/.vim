let g:markdown_syntax_conceal = 3 " Hide all

" Enable syntax highlighting on code blocks.
let g:markdown_fenced_languages = ['c', 'cpp', 'python', 'sh']

" Prevents buggy highlighting on large syntax blocks.
let g:markdown_minlines = 100

" Subsections fold by default.
let g:markdown_folding = 1
setlocal foldlevel=1

" Enable table mode
au FileType markdown :TableModeEnable
