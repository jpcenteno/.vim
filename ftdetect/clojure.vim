function! s:detect_babashka_shebang()
  if getline(1) =~# '^#!\s*.*\/bin\/env\s*bb'
    setfiletype clojure
  endif
endfunction

autocmd BufNewFile,BufRead * call s:detect_babashka_shebang()
