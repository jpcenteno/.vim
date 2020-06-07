set nocompatible
filetype plugin on
syntax on
set noswapfile

set wildignorecase " Case insensitive files

" tabs
set tabstop=4
set shiftwidth=4
set expandtab

" encodings
set encoding=utf-8
set fileencoding=utf-8

" Add support for python plugins.
" Python packages pynvim and neovim must be installed.
let g:python2_host_prog = exepath('python2')
let g:python3_host_prog = exepath('python3')

" Open help pane to the bottom.
autocmd FileType help,man wincmd J

" ----------------------------------------------------------------------------


" FIXME Abort or something like that when plug is not installed.
if empty(glob('~/.config/nvim/autoload/plug.vim'))
endif

" Aux functions for plugin declarations {{{

" Take a list of program names and return true if any of them exists in $PATH.
" I like to install only the plugins necesary for the workstation I drop this
" vimrc on.
function! s:AnyExecutable(executables) abort
    for l:exe in a:executables
        if executable(l:exe)
            return 1
        endif
    endfor
endfunction

" }}}

" Plugin declarations:
" {{{

call plug#begin('~/.config/nvim/plugged/')

" Register `vim-plug` as a plugin in order to get its documentation.
Plug 'junegunn/vim-plug'

" Coding
" Plug 'w0rp/ale'
" FIXME Come back to 'w0rp/ale' once
" https://github.com/dense-analysis/ale/pull/2963 is merged.
Plug 'unc0/ale', { 'branch': 'python-support-poetry',
                 \ 'commit': '04553d34e1423da02f1e9e7ef2f7a903dcaa4f68' }
Plug 'vim-scripts/vim-niji' " Rainbow parens
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" Text Editing {{{

" Repeat: If you've ever tried using the . command after a plugin map, you
" were likely disappointed to discover it only repeated the last native
" command inside that map, rather than the map as a whole. That disappointment
" ends today. Repeat.vim remaps . in a way that plugins can tap into it.
Plug 'tpope/vim-repeat'

" Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML
" tags, and more. The plugin provides mappings to easily delete, change and
" add such surroundings in pairs.
Plug 'tpope/vim-surround'

" Alignment
Plug 'junegunn/vim-easy-align'

" Auto Pairs: Insert or delete brackets, parens, quotes in pair.
Plug 'jiangmiao/auto-pairs'

" NERD Commenter: Comment functions so powerful—no comment necessary
Plug 'scrooloose/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Paredit performs structured editing of Lisp S-expressions in Vim. Paredit
" Mode tries to maintain the balanced state of matched characters (parenthesis
" marks, square and curly braces, double quotes).
"Plug 'vim-scripts/paredit.vim', { 'for': ['clojure', 'lisp', 'scheme']}

" Sexp: Vim-sexp brings the Vim philosophy of precision editing to
" S-expressions.
Plug 'guns/vim-sexp', { 'for': ['clojure', 'lisp', 'scheme'] }
" Better mappings by Tpope
Plug 'tpope/vim-sexp-mappings-for-regular-people',
   \ { 'for': ['clojure', 'lisp', 'scheme'] }
" Cheatsheet at: https://github.com/tpope/vim-sexp-mappings-for-regular-people


" A full-featured, super fast implementation of Shaun Lebron's parinfer. This
" repo comes with Vim plugin files that work with Vim8 and Neovim. The Rust
" library can be called from other editors that can load dynamic libraries.
" This plugin, unlike others available for Vim, implements "smart" mode.
" Rather than switching between "paren" mode and "indent" mode, parinfer uses
" information about how the user is changing the file to decide what to do.
"Plug 'eraserhd/parinfer-rust', { 'do': 'cargo build --release',
"                               \ 'for': ['clojure', 'lisp', 'scheme']}

" Commentary: Comment stuff out. Use gcc to comment out a line (takes a
" count), gc to comment out the target of a motion (for example, gcap to
" comment out a paragraph), gc in visual mode to comment out the selection,
" and gc in operator pending mode to target a comment. You can also use it as
" a command, either with a range like :7,17Commentary, or as part of a :global
" invocation like with :g/TODO/Commentary. That's it.
Plug 'tpope/vim-commentary'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" }}}

" Web dev {{{

" Emmet: tools for easier web dev.
Plug 'mattn/emmet-vim', { 'for': ['html', 'css']}

" Javascript:
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" Typescript:
if executable('tsc')
    Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
endif

" }}}

" Markdown {{{
Plug 'dhruvasagar/vim-table-mode' ", {'for': 'markdown'}
Plug 'jpcenteno/checkbox.vim', {'for': 'markdown'}
" }}}

" LaTeX
if s:AnyExecutable(['pdflatex', 'tectonic'])
    Plug 'lervag/vimtex/', {'for': ['tex', 'plaintex']}
endif


" Navigation
Plug 'ctrlpvim/ctrlp.vim'

" Nerdtree: The NERDTree is a file system explorer for the Vim editor. Using
" this plugin, users can visually browse complex directory hierarchies,
" quickly open files for reading or editing, and perform basic file system
" operations.
Plug 'scrooloose/nerdtree'
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
set hidden


" Undotree:
Plug 'mbbill/undotree'
nnoremap <Leader>u :UndotreeToggle<CR>:UndotreeFocus<cr>

if has('mac')
    Plug 'rizzatti/dash.vim'
endif

" Clojure {{{
if s:AnyExecutable(['clj', 'lein', 'boot', 'lumo'])

    " This plugin sets the 'path' for JVM languages to match the class path of
    " your current Java project. This lets commands like :find and gf work as
    " designed. I originally wrote it for Clojure, but I see no reason why it
    " wouldn't be handy for other languages as well.
    Plug 'tpope/vim-classpath', { 'for': 'clojure' }

    " Clojure REPL support.
    Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

endif
" }}}

" Tmux integration
if executable('tmux')
    Plug 'sjl/tslime.vim'
    Plug 'benmills/vimux'
endif

" Python
"Plug 'vim-scripts/python.vim', { 'for': 'python' }
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }

" Processing
if executable('processing-java')
    Plug 'sophacles/vim-processing'
endif

" Rust
if s:AnyExecutable(['rustc', 'cargo'])
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
endif

" SQL {{{
Plug 'lifepillar/pgsql.vim'
" }}}

" Aesthetic
Plug 'jeffkreeftmeijer/vim-dim'

call plug#end()
" }}}

" Plugin config

" }}} (Plugins)

" ----------------------------------------------------------------------------

" Navigation {{{

" Search
set ignorecase
set hlsearch

" Scrolling
set scrolloff=8

" Splits
" simple split switching
noremap <C-j> <C-w><C-w>
noremap <C-k> <C-w>W
set splitright " split always to the right

" Code folding
set foldenable
set foldmethod=syntax
set foldminlines=1
au FileType conf setlocal foldmethod=marker
set foldlevel=99 " unfold by default

" }}} (Navigation)

" ----------------------------------------------------------------------------

" Mappings {{{

" New map leader
let mapleader=","
let maplocalleader="-"

" ESC
if !has('nvim')
    set noesckeys " Do not wait for the esc key
endif

" Mouse
set mouse=nv

" Toggle paste mode
set pastetoggle=<F10>

" fuck shift+;
nnoremap ; :
vnoremap ; :

" easy macroing
nmap Q @q
vmap Q :norm @q<cr>

fun! s:WhitespaceClear()
    let l:save_cursor = getcurpos()
    execute "%s/\\s\\s*$//g"
    call setpos('.', l:save_cursor)
endfunction
command! WhitespaceClear call s:WhitespaceClear()

" tslime {{{
let g:tslime_ensure_trailing_newlines = 1
"let g:tslime_normal_mapping = '<localleader>t'
"let g:tslime_visual_mapping = '<localleader>t'
"let g:tslime_vars_mapping = '<localleader>T'
" }}} (tslime)

" Vimux {{{
function! VimuxSlime() " Send selection to the vimux pane
    call VimuxSendText(@v)
    "call VimuxSendKeys("Enter")
endfunction

" Send selection to repl
vmap <Leader>vs "vy :call VimuxSlime()<CR>
" Send paragraph to repl
nmap <Leader>vs vip<LocalLeader>vs<CR>
" }}}

" Spell Check {{{

" Check English
nmap <Leader>ce :setlocal spell spelllang=en_us<CR>

" Check Spanish
nmap <Leader>cs :setlocal spell spelllang=es_ar,en_us<CR>
nmap <Leader>cS :setlocal spell spelllang=es_ar<CR>

" Check Deutsch
nmap <Leader>cd :setlocal spell spelllang=de_de,en_us<CR>
nmap <Leader>cD :setlocal spell spelllang=de_de<CR>

" Disable spell checking
nmap <Leader>c0 :setlocal nospell<CR>

" }}}

" Show syntax highlighting groups for word under cursor {{{

function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nmap <Leader>P :call <SID>SynStack()<CR>

" }}}

" }}}

" ----------------------------------------------------------------------------

" ASM {{{
au BufNewFile,BufRead *.asm,*.mac set ft=nasm " Use nasm syntax
" }}}

" ----------------------------------------------------------------------------

" Aesthetic {{{

" Spell checking: red fg and underlined.
augroup SpellUnderline

    hi clear SpellBad
    autocmd ColorScheme *
        \ hi SpellBad cterm=underline ctermfg=red ctermbg=NONE

    hi clear SpellCap
    autocmd ColorScheme *
        \ hi SpellCap cterm=underline ctermfg=blue ctermbg=NONE

    hi clear SpellRare
    autocmd ColorScheme *
        \ hi SpellRare cterm=underline ctermfg=magenta ctermbg=NONE

    hi clear SpellLocal
    autocmd ColorScheme *
        \ hi SpellLocal cterm=underline ctermfg=magenta ctermbg=NONE

augroup END

" Use terminal colorscheme.
set t_Co=0 " Fix colors
colorscheme dim
" Use this to enable truecolor. I'm using the terminal defaults for now.
"if (has("termguicolors")) " Enable truecolor
"    set termguicolors " get truecolor
"endif

" Underline cursor line
set cursorline


" Highlight tabs and trailing spaces.
set list lcs=trail:·,tab:»\ ,extends:▶,precedes:◀

" No bells
set t_vb=
set vb

" Rainbow parens (With vim-niji) {{{
let g:niji_matching_filetypes = ['lisp', 'scheme', 'clojure']

let g:niji_dark_colours = [
    \ [ '81', '#ee4035'],
    \ [ '99', '#f37736'],
    \ [ '1',  '#fdf498'],
    \ [ '76', '#7bc043'],
    \ [ '3',  '#0392cf'],
    \ ]
" }}}

" }}} (style)

" ----------------------------------------------------------------------------

" Programming language specific {{{

""" Scheme
" see http://crash.net.nz/posts/2014/08/configuring-vim-for-sicp/
" see https://ds26gte.github.io/scmindent/index.html
" autocmd filetype lisp,scheme,art setlocal equalprg=scmindent.rkt

""" Clojure
au BufNewFile,BufRead *.boot setlocal ft=clojure

""" Typescript
au BufNewFile,BufRead *.ts setlocal ft=typescript " Typescript
let g:tsuquyomi_completion_detail = 1 " Show signature on completion

""" TOML
au BufNewFile,BufRead *.toml setlocal ft=dosini

""" .Xresources
" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" }}}

" ----------------------------------------------------------------------------

" Legacy {{{

nnoremap Y y$


" simple yank to common buffers
vnoremap <silent> <Leader>y "*y
vnoremap <silent> <Leader>Y "+y

" }}}

" ----------------------------------------------------------------------------
