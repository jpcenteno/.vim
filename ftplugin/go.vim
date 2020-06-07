" Go format convention prefers tabs.
setlocal noexpandtab

" Don't mark tabs. It's annoying.
setlocal lcs=trail:·,tab:\ \ ,extends:▶,precedes:◀

let b:ale_fixers = [
    \ 'gofmt',
    \ 'goimports',
    \ 'remove_trailing_lines',
    \ 'trim_whitespace'
    \]
let b:ale_fix_on_save = 1

let g:ale_fixers.go = ['gofmt', 'gobuild', 'golint', 'govet']
