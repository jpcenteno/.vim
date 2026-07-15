" Overrides default behavior mapping `.bb` files to BitBake.
"
" NOTE: Defining a separate filetype for Babashka is a bad idea:
" - Babashka relies on the `clojure` Tree-sitter parser.
" - The default `clojure-lsp` config expects the `clojure` filetype.
autocmd BufRead,BufNewFile *.bb	set ft=clojure
