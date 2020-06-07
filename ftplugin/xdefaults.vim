augroup xdefaults
    au!
    " Run `xrdb (1)` on save for instant feedback.
    au BufWritePost <buffer> !xrdb %
augroup END
