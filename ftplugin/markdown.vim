setlocal tabstop=2 shiftwidth=2

let g:markdown_syntax_conceal = 3 " Hide all

" Enable syntax highlighting on code blocks.
" - There is no option to enable everything, so I made my best effort to keep
"   a comprehensive list of the languages I coded in the recent past.
" - Use `:'<,'>sort` to keep it organized.
let g:markdown_fenced_languages = [
    \ 'c',
    \ 'clojure',
    \ 'cmake',
    \ 'cpp',
    \ 'glsl',
    \ 'go',
    \ 'haskell',
    \ 'html',
    \ 'javascript',
    \ 'json',
    \ 'make',
    \ 'nasm',
    \ 'perl',
    \ 'python',
    \ 'rust',
    \ 'sh',
    \ 'st',
    \ 'tex',
    \ 'tex',
    \ 'typescript',
    \ 'vim',
    \ 'yaml',
    \ 'zsh',
\]

" Prevents buggy highlighting on large syntax blocks.
let g:markdown_minlines = 100

" Subsections fold by default.
let g:markdown_folding = 1
" setlocal foldlevel=1

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
