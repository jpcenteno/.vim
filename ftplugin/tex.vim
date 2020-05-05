let g:tex_flavor='latex'

" Preferred PDF readers:
" - On Mac OS, vimtex defaults to `open (1)` using Preview.
" - On Linux, I love `zathura (1)`.
if executable('zathura') " Try to use zathura
    let g:vimtex_view_method='zathura'
end

" Preferred compilers:
" 1. `latexmk`
" 2. `tectonic`
if executable('latexmk')
    let g:vimtex_compiler_method='latexmk'
elseif executable('tectonic')
    let g:vimtex_compiler_method='tectonic'
endif

" [Mac OS only] Auto refresh the document on `Preview.app`. 
function! s:MacOsPreviewReload(status)
   if (a:status == 1) " Only on successful compilations
       silent exec '! osascript -e "tell application \"Preview\" to activate"'
   endif
endfunction
" FIXME use it (or maybe discard it)

" Use folds.
let g:vimtex_fold_enabled=1
