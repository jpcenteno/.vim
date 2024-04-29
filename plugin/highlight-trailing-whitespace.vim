" ╔════════════════════════════════════════════════════════════════════════╗
" ║ Extra Whitespace Highlighter                                           ║
" ╚════════════════════════════════════════════════════════════════════════╝
"
" ## Synopsis
"
" This _plugin_ adds syntax highlighting for:
"
" - Trailing whitespaces.
" - Space characters that come before a tab.
"
" ## Known issues
"
" It does not highlight trailing whitespaces on comments.

" ╔════════════════════════════════════════════════════════════════════════╗
" ║ Syntax rules for extra whitespace                                      ║
" ╚════════════════════════════════════════════════════════════════════════╝

" Add a syntax rule for trailing whitespace.
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
"                                           ┌────┌─┌───────
"                                           │    │ │
"                                           │    │ ╰──▶ Space characters before a tab.
"                                           │    │
"                                           │    ╰────▶ OR operator.
"                                           │
"                                           ╰─────────▶ Trailing whitespaces.
"
" Source: https://vim.fandom.com/wiki/Highlight_unwanted_spaces#Highlighting_with_the_syntax_command

" ╔════════════════════════════════════════════════════════════════════════╗
" ║ Toggling functions                                                     ║
" ╚════════════════════════════════════════════════════════════════════════╝

function! s:trailing_whitespace_highlihghting_on() abort
  highlight ExtraWhitespace ctermbg=red guibg=red
endfunction

function! s:trailing_whitespace_highlihghting_off() abort
  highlight ExtraWhitespace NONE
endfunction

" ╔════════════════════════════════════════════════════════════════════════╗
" ║ Triggers                                                               ║
" ╚════════════════════════════════════════════════════════════════════════╝

call s:trailing_whitespace_highlihghting_on()

autocmd ColorScheme * call s:trailing_whitespace_highlihghting_on()
autocmd BufWinEnter * call s:trailing_whitespace_highlihghting_on()

" Disable highlighting while on insert mode (It's annoying).
autocmd InsertEnter * call s:trailing_whitespace_highlihghting_off()
autocmd InsertLeave * call s:trailing_whitespace_highlihghting_on()
