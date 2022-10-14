" FIXME do something with the output
function! fzf#globals()
  let l:globals = deepcopy(keys(g:))
  let l:globals = map(l:globals, '"g:" . v:val')
  return fzf#run(fzf#wrap({ 'source' : l:globals }))
endfunction

command! Globals call fzf#globals()
