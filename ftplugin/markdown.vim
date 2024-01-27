setlocal ts=2 sts=2 sw=2 expandtab
setlocal conceallevel=2

au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
