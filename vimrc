" General {{{

" Basics
set nocompatible
filetype plugin on
syntax on
set noswapfile

" tabs
set tabstop=4
set shiftwidth=4
set expandtab

" encodings
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc

" title for bash
set title
set titlestring=Vim\ -\ %t%(\ %M%)
set titleold=Terminal

" }}} (general)

" ----------------------------------------------------------------------------

" Plugins {{{

" Autoinstall Plug on Vim or Neovim:
" {{{

" Autoinstall on NeoVim
if has('nvim') && empty(glob('~/.config/nvim/autoload/plug.vim'))

    echo "Installing vim-plug..."

    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC

endif

" Autoinstall on Vim
if !has('nvim') && empty(glob('~/.vim/autoload/plug.vim'))

    echo "Installing vim-plug..."

    " Autoinstall on Vim
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC

endif

" }}}

" Plugin declarations:
" {{{

call plug#begin('~/.config/nvim/plugged/')

" Register `vim-plug` as a plugin in order to get its documentation.
Plug 'junegunn/vim-plug'

" Coding
" Plug 'vim-syntastic/syntastic' " Syntax Checking
Plug 'w0rp/ale'
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
if has('python') || has('python3')
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
endif

" }}}

" Web dev {{{

" Emmet: tools for easier web dev.
Plug 'mattn/emmet-vim', { 'for': ['html', 'css']}

" Javascript:
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" Typescript:
Plug 'Shougo/vimproc.vim', {'do' : 'make'} " Req for typescript
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
Plug 'Quramy/tsuquyomi', {'for': 'typescript'}

" }}}

" Markdown {{{
Plug 'dhruvasagar/vim-table-mode', {'for': 'markdown'}
Plug 'tpope/vim-markdown', {'for': 'markdown'}
" }}}

" LaTeX {{{

" Vimtex: IDE like features for LaTeX.
Plug 'lervag/vimtex/', {'for': ['tex', 'plaintex']}
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'

let g:vimtex_fold_enabled=1
"autocmd Filetype tex,latex,context,plaintex setlocal foldmethod=marker

" }}}


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

" Clojure {{{
if executable('lein') || executable('boot') || executable('lumo')

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
let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_docstring=0
let g:SimpylFold_fold_import=0

" Processing
Plug 'sophacles/vim-processing'

" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" SQL {{{
Plug 'lifepillar/pgsql.vim'
" }}}

" Style
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-scripts/less.vim'
Plug 'j-tom/vim-old-hope'
Plug 'pgdouyon/vim-yin-yang'
Plug 'nightsense/stellarized'
Plug 'liuchengxu/space-vim-dark'
Plug 'junegunn/seoul256.vim'
Plug 'rakr/vim-two-firewatch'
Plug 'rakr/vim-one'
Plug 'sjl/badwolf'
Plug 'NLKNguyen/papercolor-theme'
Plug 'srcery-colors/srcery-vim'


Plug 'vim-airline/vim-airline'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'

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
au FileType vim setlocal foldmethod=marker
au FileType conf setlocal foldmethod=marker
set foldlevel=99 " unfold by default

" ctrlp
" ignores for nerdtree and ctrlp
"set wildignore+=*/static/*

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
map <C-space> <Esc>
imap <C-space> <Esc>
vmap <C-space> <Esc>

" Mouse
set mouse=nv

" Toggle paste mode
set pastetoggle=<F10>

" fuck shift+;
nnoremap - :
vnoremap - :
nnoremap ; :
vnoremap ; :

" easy macroing
nmap Q @q
vmap Q :norm @q<cr>

" Clear unwanted whitespace.
nmap <silent> <Leader>c :%s/\s\+$//e<CR>,s

" Turn hilighting off
nnoremap <silent> <Leader>s :nohls<CR>

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

" Fix latex copypaste {{{
function! FixLatexPasteNormal()

    let l:save = winsaveview() " Save cursor position

    " Spanish:
    silent! %s/a ́/á/g
    silent! %s/e ́/é/g
    silent! %s/i ́/í/g
    silent! %s/o ́/ó/g
    silent! %s/u ́/ú/g
    silent! %s/n ̃/ñ/g

    call winrestview(l:save) " Restore cursor position

endfunction
" }}}

" }}}

" ----------------------------------------------------------------------------

" Coding {{{

" ASM {{{
au BufNewFile,BufRead *.asm,*.mac set ft=nasm " Use nasm syntax
autocmd Filetype nasm setlocal foldmethod=marker
" }}}

" Go {{{

autocmd FileType go setlocal expandtab!
" No need for tab alerts
autocmd FileType go setlocal lcs=trail:·,tab:\ \ ,extends:▶,precedes:◀
autocmd FileType go setlocal ignorecase!

" }}}

" Web Dev {{{

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
    au FileType javascript syntax on
augroup END

" / Web Dev }}}

" SQL {{{

" Use PgSQL as the default SQL dialect
let g:sql_type_default = 'pgsql'

" }}}

" Syntastic {{{

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" C++ 11
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" / Syntastic }}}

" YAML {{{

" 2chars tabs for yaml
autocmd Filetype yaml setlocal ts=2 sw=2 expandtab

" }}}

" LaTeX {{{


" }}}

" Zsh conf files {{{
autocmd Filetype zsh setlocal foldmethod=marker
" }}}

" Markdown {{{

" Enable markdown folding
let g:markdown_folding = 1
au FileType markdown :set foldlevel=1 " Fold subsections

let g:markdown_syntax_conceal = 3 " Hide all

" }}}

" VimScript {{{

au FileType vim setlocal foldmethod=marker foldlevel=0

" }}}

" }}}

" ----------------------------------------------------------------------------

" Style {{{

" Select colorscheme based on `truecolor` support.
if ($COLORTERM ==# 'truecolor' || $COLORTERM ==# '24bit') && has("termguicolors")
    set termguicolors " get truecolor
    colorscheme srcery
else
    set t_Co=256 " Fix colors
    colorscheme stellarized
endif

" Highlight issues with whitespace.
" A tab: "	"
" Trailing space:    
set list lcs=trail:·,tab:»\ ,extends:▶,precedes:◀

" Colorscheme rotator
function! MyClockRotateColorscheme()

    if strftime('%H') >= 9 && strftime('%H') < 19
        set bg=light
        colorscheme yang
    else
        set bg=dark
        colorscheme stellarized

    endif

endfunction

"let s:rotatorTimer = timer_start(60 * 1000, 'MyClockRotateColorscheme')
"call MyClockRotateColorscheme()

" Colorscheme modifications {{{

function! s:myColorSchemeMods()
    " Black Background
    "hi Normal ctermbg=none
    " underline current line
    " set cursorline
    " hi cursorLine cterm=underline ctermbg=none " Black bg, white underline
    " Gray out Line Numbers
    hi LineNr ctermfg=DarkGray ctermbg=none
endfunction

" call s:myColorSchemeMods()

" }}}

" Distraction free with Goyo and Limelight {{{

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_paragraph_span = 1
" Highlighting priority (default: 10). Set it to -1 not to overrule hlsearch:
let g:limelight_priority = -1
" Key bindings
nmap <Leader>l :Limelight!!<CR>

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
autocmd! User GoyoLeave call s:myColorSchemeMods()
" }}

" No bells
set t_vb=
set vb

" Relative line numbers.
" set relativenumber
" set nu " Show the absolute line number instead of 0

" Highlight the column after textwidth
set colorcolumn=+1

" Airline config {{{

" Cool symbols
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

" Diminish mode names
let g:airline_mode_map = {
  \ '__'     : '-',
  \ 'c'      : 'C',
  \ 'i'      : 'I',
  \ 'ic'     : 'I',
  \ 'ix'     : 'I',
  \ 'n'      : 'N',
  \ 'multi'  : 'M',
  \ 'ni'     : 'N',
  \ 'no'     : 'N',
  \ 'R'      : 'R',
  \ 'Rv'     : 'R',
  \ 's'      : 'S',
  \ 'S'      : 'S',
  \ ''     : 'S',
  \ 't'      : 'T',
  \ 'v'      : 'V',
  \ 'V'      : 'V',
  \ ''     : 'V',
  \ }

" Minimal cursor `line:char` coordinates
let g:airline_section_z = airline#section#create(['%l', ':', '%v'])

" }}}

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

" }}}

" ----------------------------------------------------------------------------

" Legacy {{{

nnoremap Y y$


" simple yank to common buffers
vnoremap <silent> <Leader>y "*y
vnoremap <silent> <Leader>Y "+y

" }}}

" ----------------------------------------------------------------------------
