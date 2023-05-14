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

" Clip longer lines instead of wrapping
set nowrap

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

" See: https://github.com/junegunn/vim-plug/wiki/tips#conditional-activation
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

function! NoVSCode(...)
  let opts = get(a:000, 0, {})
  return Cond(!exists('g:vscode'), opts)
endfunction

call plug#begin()

" Utilities:

" This plugin provides tools for running async commands from vim.
" - ⚠️  `vim-jack-in` depends on this package.
" Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'

" Register `vim-plug` as a plugin in order to get its documentation.
Plug 'junegunn/vim-plug'

" Symbol pair manipulation:
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

Plug 'tpope/vim-commentary'

Plug 'AdamWhittingham/vim-copy-filename'

" Align
Plug 'junegunn/vim-easy-align'

" LSP
Plug 'williamboman/mason.nvim', NoVSCode()
Plug 'williamboman/mason-lspconfig.nvim', NoVSCode()
Plug 'neovim/nvim-lspconfig', NoVSCode()

" LSP -> LSP Wrapper for non-lsp tools
Plug 'nvim-lua/plenary.nvim', NoVSCode() " Required by null-ls
Plug 'jose-elias-alvarez/null-ls.nvim', NoVSCode()

" LSP -> Diagnostics (Errors, Warnings, etc)
Plug 'kyazdani42/nvim-web-devicons', NoVSCode() " Required by `Trouble`.
Plug 'folke/trouble.nvim', NoVSCode()

" LSP -> Auto complete
Plug 'hrsh7th/cmp-nvim-lsp', NoVSCode()
Plug 'hrsh7th/cmp-buffer', NoVSCode()
Plug 'hrsh7th/cmp-path', NoVSCode()
Plug 'hrsh7th/cmp-cmdline', NoVSCode()
Plug 'quangnguyen30192/cmp-nvim-ultisnips', NoVSCode()
Plug 'hrsh7th/nvim-cmp', NoVSCode()

" Programming Language specific:
" Plug 'clojure-vim/vim-jack-in', { 'for': 'clojure' }
Plug 'elixir-editors/vim-elixir', NoVSCode({'for': 'elixir'})
Plug 'mhinz/vim-mix-format', NoVSCode({'for': 'elixir'})
Plug 'ledger/vim-ledger', NoVSCode({'for': 'ledger'})
Plug 'tpope/vim-liquid', NoVSCode({'for': 'liquid'})
let g:lisp_fts = [ 'clojure', 'lisp', 'scheme', 'racket' ]
Plug 'Olical/conjure', NoVSCode({ 'tag': 'v4.23.0', 'for' : g:lisp_fts })
Plug 'guns/vim-sexp', { 'for' : g:lisp_fts }
Plug 'tpope/vim-sexp-mappings-for-regular-people', NoVSCode({ 'for' : g:lisp_fts })
Plug 'junegunn/rainbow_parentheses.vim', NoVSCode({ 'for' : g:lisp_fts })
Plug 'mracos/mermaid.vim', NoVSCode({'for': 'mermaid'})
Plug 'LnL7/vim-nix', NoVSCode({ 'for': 'nix' })
Plug 'rust-lang/rust.vim', NoVSCode({ 'for': 'rust' })
Plug 'cespare/vim-toml', NoVSCode({ 'for': 'toml' })

" Aesthetics
Plug 'sainnhe/everforest', NoVSCode()
Plug 'jeffkreeftmeijer/vim-dim', NoVSCode()
Plug 'itchyny/lightline.vim', NoVSCode()
Plug 'ryanoasis/vim-devicons', NoVSCode()

" Navigation

Plug 'junegunn/fzf', NoVSCode({ 'do': { -> fzf#install() } })
Plug 'junegunn/fzf.vim', NoVSCode()

Plug 'preservim/nerdtree', NoVSCode()
Plug 'liuchengxu/vim-which-key', NoVSCode()

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

" ------------------------------------------------------------------------------
" LSP:
" ------------------------------------------------------------------------------

if !exists('g:vscode')
  lua require("lsp")
endif

" ------------------------------------------------------------------------------
" Aesthetics:
" ------------------------------------------------------------------------------

" Prevent syntax highlighting from breaking after very long lines.
set synmaxcol=0

" Make the sign gutter fixed width.
set signcolumn=yes:1

colorscheme dim

set cursorline

function! SynGroup()                                                            
  let l:s = synID(line('.'), col('.'), 1)                                       
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
