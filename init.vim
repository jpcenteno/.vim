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

set completeopt=menu,menuone,noselect

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

" Automatically install Vim-Plug if missing:
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Automatically install missing plugins on startup:
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

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

Plug 'tpope/vim-commentary'

" Align
Plug 'junegunn/vim-easy-align'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'hrsh7th/nvim-cmp'

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
Plug 'guns/vim-sexp', { 'for' : [ 'clojure' ] }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for' : [ 'clojure' ] }

" Lang -> Nix
Plug 'LnL7/vim-nix'

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
Plug 'junegunn/seoul256.vim'
Plug 'sainnhe/everforest'

Plug 'itchyny/lightline.vim'

Plug 'ryanoasis/vim-devicons'

" Navigation

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'preservim/nerdtree'

Plug 'liuchengxu/vim-which-key'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

" ------------------------------------------------------------------------------
" LSP:
" ------------------------------------------------------------------------------

lua << EOF
require("lsp")
EOF

" ------------------------------------------------------------------------------
" Aesthetics:
" ------------------------------------------------------------------------------

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set t_Co=256


set background=dark
let g:everforest_background = 'medium'
let g:everforest_better_performance = 1
let g:airline_theme = 'everforest'
colorscheme everforest

hi CursorLine ctermbg=374247

function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
