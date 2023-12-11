
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': 'md'}]

" Mappings between extensions and syntax.
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" Don't create a temporal wiki for `.md` files outside wikis listed in
" `g:vimwiki_list`.
let g:vimwiki_global_ext = 0


" This makes vimwiki `.md` links as [text](fname.md) instead of [text](fname)
let g:vimwiki_markdown_link_ext = 1

" Add 2 newlines after heading instead of 1.
let g:vimwiki_markdown_header_style = 2

let g:vimwiki_key_mappings = { 'global': 0 }
