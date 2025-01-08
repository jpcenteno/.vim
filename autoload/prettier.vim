" Try to locate prettier on the current environment and use it to format the
" current buffer.
"
" ~~ Keep it simple. We don't need a third party plugin for this. ~~
"
" See also the `ftplugin` files for JS, JSX, TS and TSX.
function! prettier#format_buffer() abort
  let l:cursor_position = getpos('.')

  if executable("prettier")
    execute ':%!prettier --stdin-filepath %:p'
  elseif executable("npx") && isdirectory("./node_modules/prettier")
    " The flag `--no-install` prevents `npx` from installing the dependency
    " if not installed. This should be redundant with the `isdirectory(...)`
    " expression from above, but it's good to double check.
    execute ':%!npx --no-install prettier --stdin-filepath %:p'
  else
    echom "Prettier not found."
  endif

  call setpos('.', l:cursor_position)
endfunction
