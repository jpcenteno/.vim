setlocal tabstop=2 shiftwidth=2

" Format before save using prettier (If available).
augroup PrettierBeforeSave
  autocmd!
  autocmd BufWritePre *.js,*.jsx call EvalPrettierOnBuffer()
augroup END
