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

" Insert a link in reference style. It will prompt for link name (the text to
" be read), reference name and the link location.
function! MDAddReferenceLink()

    call inputsave()
    let l:name = input('Enter link text: ')
    let l:ref = input('Enter reference name: ')
    let l:loc = input('Enter link location: ')
    call inputrestore()

    " Insert the referenced link URL at the end of the document.
    call append(line('$'), '[' . l:ref . ']: ' . l:loc)

    " Insert the link with a reference at cursor position
    execute 'normal a' . '[' . l:name . '](' . l:ref . ')'

endfunction

imap <C-l> <esc>:call MDAddReferenceLink()<cr>a
