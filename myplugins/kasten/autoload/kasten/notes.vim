function! kasten#notes#new() abort
  if ! executable("kasten-cli")
    throw "Error: 'kasten-cli' not found in PATH."
  endif

  try
    let l:title = input('Enter a Title: ')
  catch /^Vim\%((\a\+)\)\=:Interrupt$/
    echo "Cancelled: User interrupt"
    return
  endtry

  if empty(l:title)
    redraw " Clear the 'Enter a title: ...' message from the command area.
    echo "Cancelled: Empty title."
    return
  endif

  let l:cmd = 'kasten-cli note new -d ~/Documents/Notes -t' . shellescape(l:title)
  let l:path = system(l:cmd)

  if v:shell_error
    echoerr "Error while running `kasten-cli note new`."
  endif

  execute 'edit' fnameescape(trim(l:path)) 
endfunction

call kasten#notes#new()
