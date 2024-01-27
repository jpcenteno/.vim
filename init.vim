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

set textwidth=80

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

" This helper function prevents a plugin from being activated when NeoVim is
" used as a backend for the VSCode NeoVim plugin. Use it to reduce the overhead
" when there it's functionality is being replaced by another VSCode plugin.
"
" Rationale:
" ----------
"
" - Prevents `:PlugClean` from removing this plugin when ran from VSCode.
" - Reduces overhead when this plugin functionality is replaced by another
"   VSCode plugin.
function! NoVSCode(...)
  let opts = get(a:000, 0, {})
  return Cond(!exists('g:vscode'), opts)
endfunction

" This function prevents a plugin from loading when this config is being run
" either by plain old Vim or as a backend for VSCode NeoVim.
"
" It takes a VimPlug config dictionary and returns a VimPlug config dictionary.
function! NeoVimButNoNoVSCode(...)
  let opts = get(a:000, 0, {})
  return Cond(has('nvim'), NoVSCode(opts))
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
Plug 'jpcenteno/boxed-comments.vim'

Plug 'AdamWhittingham/vim-copy-filename'

" Align
Plug 'junegunn/vim-easy-align'

" ╔════════════════════════════════════════════════════════════════════════╗
" ║ LSP                                                                    ║
" ╚════════════════════════════════════════════════════════════════════════╝

" The plugin `lsp-zero` provides a no-brainer setup for LSP on neovim.
"
" All the settings related to LSP should be set together at
" `after/plugin/lsp.lua`.
"
" Troubleshooting:
" ----------------
"
" On a buffer, use `:LspInfo` to check if pertinent LSP server is actually
" running.

Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'} " Required by `lsp-zero`
Plug 'rafamadriz/friendly-snippets' " snippet collection.
Plug 'benfowler/telescope-luasnip.nvim' " List snippets with Telescope.

Plug 'neovim/nvim-lspconfig', NeoVimButNoNoVSCode()                     " Required by `lsp-zero`
Plug 'hrsh7th/nvim-cmp', NeoVimButNoNoVSCode()                          " Required by `lsp-zero`
Plug 'hrsh7th/cmp-nvim-lsp', NeoVimButNoNoVSCode()                      " Required by `lsp-zero`
Plug 'saadparwaiz1/cmp_luasnip', NeoVimButNoNoVSCode() " Add luasnips to cmp.
Plug 'FelipeLema/cmp-async-path', NeoVimButNoNoVSCode() " Autocomplete file system paths.
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}

Plug 'mfussenegger/nvim-lint', NeoVimButNoNoVSCode()

" `conform.nvim` is a framework for setting up autoformatters.
Plug 'stevearc/conform.nvim', NeoVimButNoNoVSCode()

" Diagnostics display
Plug 'folke/trouble.nvim', NeoVimButNoNoVSCode()

" ╔════════════════════════════════════════════════════════════════════════╗
" ║ Programming language specific plugins:                                 ║
" ╚════════════════════════════════════════════════════════════════════════╝

" Plug 'clojure-vim/vim-jack-in', { 'for': 'clojure' }
Plug 'elixir-editors/vim-elixir', NoVSCode({'for': 'elixir'})
Plug 'mhinz/vim-mix-format', NoVSCode({'for': 'elixir'})
Plug 'ledger/vim-ledger', NoVSCode({'for': 'ledger'})
let g:lisp_fts = [ 'clojure', 'lisp', 'scheme', 'racket' ]
Plug 'Olical/conjure', { 'tag': 'v4.48.0', 'for' : g:lisp_fts }
Plug 'guns/vim-sexp', { 'for' : g:lisp_fts }
Plug 'tpope/vim-sexp-mappings-for-regular-people', NoVSCode({ 'for' : g:lisp_fts })
Plug 'mracos/mermaid.vim', NoVSCode({'for': 'mermaid'})
Plug 'LnL7/vim-nix', NoVSCode({ 'for': 'nix' })
Plug 'rust-lang/rust.vim', NoVSCode({ 'for': 'rust' })
Plug 'cespare/vim-toml', NoVSCode({ 'for': 'toml' })
Plug 'mattdf/vim-yul', NoVSCode({ 'for': 'yul' }) " Yul syntax highlighting
Plug 'dhruvasagar/vim-table-mode', { 'for': [ 'markdown' ] }

" Aesthetics
Plug 'sainnhe/everforest', NoVSCode()
Plug 'jeffkreeftmeijer/vim-dim', NoVSCode()
Plug 'itchyny/lightline.vim', NoVSCode()
Plug 'ryanoasis/vim-devicons', NoVSCode()

" Navigation

Plug 'nvim-lua/plenary.nvim', NeoVimButNoNoVSCode(), " Telescope dependency.
Plug 'nvim-telescope/telescope-fzy-native.nvim', NeoVimButNoNoVSCode() " `fzy` based sorter for Telescope.
Plug 'nvim-telescope/telescope.nvim', NeoVimButNoNoVSCode({ 'branch': '0.1.x' })

Plug 'preservim/nerdtree', NoVSCode()
Plug 'liuchengxu/vim-which-key', NoVSCode()

" Switch seamlessly between Vim and Tmux splits using `C-{h,j,k,l}`. This plugin
" requires the same mappings to be set on `tmux.config` so we can use the same
" keybindings to switch back to vim panes.
"
" See: `https://github.com/christoomey/vim-tmux-navigator` for instructions on
" how to set that up on Tmux.
Plug 'christoomey/vim-tmux-navigator', NoVSCode()

Plug 'epwalsh/obsidian.nvim', { 'for': ['markdown'], 'tag': 'v2.8.0' }

call plug#end()

" ------------------------------------------------------------------------------
" Tools:
" ------------------------------------------------------------------------------

function! s:debug_runtime_path() abort
  " Create a new empty buffer
  execute 'new'

  " Set the buffer to read-only mode
  setlocal readonly

  " Get the runtimepath
  let runtimepath = &runtimepath

  " Split the runtimepath by comma and print each line in the buffer
  for path in split(runtimepath, ',')
    call append('$', path)
  endfor
endfunction

command! -nargs=0 DebugRuntimePath call s:debug_runtime_path()

" ------------------------------------------------------------------------------
" Tools:
" ------------------------------------------------------------------------------

function! s:debug_runtime_path() abort
  " Create a new empty buffer
  execute 'new'

  " Set the buffer to read-only mode
  setlocal readonly

  " Get the runtimepath
  let runtimepath = &runtimepath

  " Split the runtimepath by comma and print each line in the buffer
  for path in split(runtimepath, ',')
    call append('$', path)
  endfor
endfunction

command! -nargs=0 DebugRuntimePath call s:debug_runtime_path()

" ------------------------------------------------------------------------------
" Aesthetics:
" ------------------------------------------------------------------------------

" Prevent syntax highlighting from breaking after very long lines.
set synmaxcol=0

" Make the sign gutter fixed width.
set signcolumn=yes:1

set t_Co=16
colorscheme dim
hi link NormalFloat Normal " Fix conjure HUD unreadability problem.
hi link WinSeparator Normal " Minimal window separators.
hi ErrorMsg ctermbg=NONE ctermfg=9 " Make errors readable

set cursorline

function! SynGroup()                                                            
  let l:s = synID(line('.'), col('.'), 1)                                       
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
