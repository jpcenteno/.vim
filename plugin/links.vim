" Algorithm to find a regular expression 
"
"
"
function! s:matchstrposAroundCursor(pat) abort
    let result = matchstrpos(getline('.'), pat)
    let str = result[0]
    let start = result[1]
    let end = result[2]

    if start == -1
      return result " => ["", -1, -1]
    endif

endfunction

function! ExtractReferenceLinkUnderCursor() abort
    let line = getline('.')
    let cursor_col = col('.')
    let regex = '\[[^][]\+\]\[\([^\]]\+\)\]'

    let l:i = 0
    let link_string = 0
    let start = 0
    let end = 0
    while 1
      let match = matchstrpos(line, regex, start, l:i)
      let link_string = match[0]
      let start = match[1]
      let end = match[2]

      echo "[l:i, link_string, start, end] = [" . l:i . ", " . link_string . ", " . start ", " . end . "]"

      if start == -1
        " There are no substrings left matching the pattern.
        echo "No matches left at l:i = " . l:i
        return match " => ["", -1, -1]
      endif

      let l:i = l:i + 1
    endwhile
endfunction

" [a][b] [c][d] [e][f]
