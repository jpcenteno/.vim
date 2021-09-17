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

" ------------------------------------------------------------------------------
" Basic Mappings:
" ------------------------------------------------------------------------------

nnoremap <SPACE> <Nop>
let mapleader=" "

nnoremap ; :
vnoremap ; :

nnoremap Q @q
vnoremap Q @q

" Buffer bindings
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>bd :bd<CR>
nnoremap <Leader>bD :bd!<CR>

" ------------------------------------------------------------------------------
" Plugin Declarations:
" ------------------------------------------------------------------------------

" Add support for python plugins.
" Python packages pynvim and neovim must be installed.
let g:python2_host_prog = exepath('python2')
let g:python3_host_prog = exepath('python3')

call plug#begin()

  " Register `vim-plug` as a plugin in order to get its documentation.
  Plug 'junegunn/vim-plug'

  " Symbol pair manipulation:
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-surround'

  " Lang -> Elixir
  Plug 'elixir-editors/vim-elixir'
  Plug 'slashmili/alchemist.vim'

  " Lang -> Ledger
  Plug 'ledger/vim-ledger'

  " Lang -> Rust
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }

  " Lang -> TOML
  Plug 'cespare/vim-toml', { 'for': 'toml' }

  " Themes
  Plug 'jeffkreeftmeijer/vim-dim'

  " Navigation

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Snippets
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

call plug#end()

" ------------------------------------------------------------------------------
" Aesthetics:
" ------------------------------------------------------------------------------

colorscheme dim
