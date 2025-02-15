setlocal ts=2 sts=2 sw=2 expandtab
setlocal conceallevel=2

vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" Bold text (98 is the ASCII code for `i`)
let b:surround_98 = "**\r**"

" Italic text. (105 is the ASCII code for `i`)
let b:surround_105 = "_\r_"

" Code block
let b:surround_99 = "```\1language: \1\n\r\n```" " 99 is the ASCII for `c`.
