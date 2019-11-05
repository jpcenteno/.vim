let g:tex_flavor='latex'

" Set the document viewer:
" - My fav program for this is zathura.
" - On Mac OS it defaults to `Open` whith Preview.
if executable('zathura') " Try to use zathura
    let g:vimtex_view_method='zathura'
end

" Refresh the PDF on Preview.app. Mac OS only.
"function! MacOsPreviewReload(status)
"    if (a:status == 1) " Only on successful compilations
"        silent exec '! osascript -e "tell application \"Preview\" to activate"'
"    endif
"endfunction
"if has('mac')
"    let g:vimtex_view_general_callback = 'MacOsPreviewReload'
"endif

let g:vimtex_fold_enabled=1
"autocmd Filetype tex,latex,context,plaintex setlocal foldmethod=marker
