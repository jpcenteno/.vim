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

" ------------------------------------------------------------------------------
" Basic Mappings:
" ------------------------------------------------------------------------------

nnoremap <SPACE> <Nop>
let mapleader=" "

nnoremap ; :
vnoremap ; :

" ------------------------------------------------------------------------------
" Plugin Declarations:
" ------------------------------------------------------------------------------

call plug#begin()

  " Register `vim-plug` as a plugin in order to get its documentation.
  Plug 'junegunn/vim-plug'

  " Symbol pair manipulation:
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-surround'

  " Lang -> Elixir
  Plug 'elixir-editors/vim-elixir'
  Plug 'slashmili/alchemist.vim'

  " Lang -> Rust
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }

  " Themes
  Plug 'jeffkreeftmeijer/vim-dim'

  " Navigation

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

call plug#end()

" ------------------------------------------------------------------------------
" Aesthetics:
" ------------------------------------------------------------------------------

colorscheme dim
