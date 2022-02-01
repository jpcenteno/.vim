" ------------------------------------------------------------------------------
" Basic Config:
" ------------------------------------------------------------------------------

set nocompatible
filetype plugin on
syntax on

set tabstop=4 shiftwidth=4 expandtab
set encoding=utf-8 fileencoding=utf-8

set noswapfile

" Keep the buffers hidden when closed.
set hidden

" Perform case-insensitive searches unless the search contains uppercase
" characters.
set smartcase

" Enable spellcheck
setlocal spell spelllang=en_us

" ------------------------------------------------------------------------------
" Basic Mappings:
" ------------------------------------------------------------------------------

set mouse=a

nnoremap <SPACE> <Nop>
let mapleader=" "

nnoremap , <Nop>
let maplocalleader=","

nnoremap ; :
vnoremap ; :

nnoremap Q @q
vnoremap Q @q

nnoremap Y y$

" Buffer bindings
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>bd :bd<CR>
nnoremap <Leader>bD :bd!<CR>

function! s:insertDate()
  execute ':normal! i ' . strftime('%Y-%m-%d')
endfun

command! InsertDate call s:insertDate()

function! s:insertDateTime()
  execute ':normal! i ' . strftime('%Y-%m-%d %H:%M')
endfun

command! InsertDateTime call s:insertDateTime()


" ------------------------------------------------------------------------------
" Plugin Declarations:
" ------------------------------------------------------------------------------

" Add support for python plugins.
" Python packages pynvim and neovim must be installed.
let g:python2_host_prog = exepath('python2')
let g:python3_host_prog = exepath('python3')

call plug#begin()

" Utilities:

" This plugin provides tools for running async commands from vim.
" - ⚠️  `vim-jack-in` depends on this package.
Plug 'tpope/vim-dispatch'

" Register `vim-plug` as a plugin in order to get its documentation.
Plug 'junegunn/vim-plug'

" Symbol pair manipulation:
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" Align
Plug 'junegunn/vim-easy-align'

" Lang -> Clojure
Plug 'clojure-vim/vim-jack-in', { 'for': 'clojure' }

" Lang -> Elixir
Plug 'elixir-editors/vim-elixir'
"Plug 'slashmili/alchemist.vim'

" Lang -> Ledger
Plug 'ledger/vim-ledger'

" Lang -> Liquid (Jekyll Templates)
Plug 'tpope/vim-liquid'

" Lang -> Lisp (Regardles of wich dialect)
Plug 'Olical/conjure', {'tag': 'v4.23.0'}
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

" Lang -> Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Lang -> TOML
Plug 'cespare/vim-toml', { 'for': 'toml' }

" Themes
Plug 'rose-pine/neovim'
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'arcticicestudio/nord-vim'
Plug 'rakr/vim-one'
Plug 'altercation/vim-colors-solarized'

Plug 'itchyny/lightline.vim'

Plug 'ryanoasis/vim-devicons'

" Navigation

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'preservim/nerdtree'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

" ------------------------------------------------------------------------------
" Aesthetics:
" ------------------------------------------------------------------------------

set bg=dark
colorscheme nord

function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

