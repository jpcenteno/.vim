au BufNewFile,BufRead *.json
      \ if getline(1) == '---' |
      \   let b:liquid_subtype = 'json' |
      \   set ft=liquid |
      \ endif
