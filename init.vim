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

" Use the system clipboard register. For example, `<C-c>` with `y2y` ot copy `2`
" lines to the clipboard, `<C-c>d2d` to cut 2 lines, etc.
nnoremap <C-c> "+
vnoremap <C-c> "+

" ------------------------------------------------------------------------------
" Plugin Declarations:
" ------------------------------------------------------------------------------

lua require("config.lazy")

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

" Register `vim-plug` as a plugin in order to get its documentation.
Plug 'junegunn/vim-plug'

" ╔════════════════════════════════════════════════════════════════════════╗
" ║ Programming language specific plugins:                                 ║
" ╚════════════════════════════════════════════════════════════════════════╝

" Plug 'clojure-vim/vim-jack-in', { 'for': 'clojure' }

" Note: Don't add a `'for': [ ... Lisps ... ]` configuration to Conjure,
" Vim-Sexp or `vim-sexp-mappings-for-regular-people`. They implement
" lazy-loading internally and doing this causes the plugin to ignore the first
" Lisp buffer.
Plug 'Olical/conjure'

" Navigation

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

set scrolloff=5 " Vertical scroll margin

" Prevent syntax highlighting from breaking after very long lines.
set synmaxcol=0

" Overrides some of the color scheme settings for readability and minimalism.
function! s:ColorschemeOverrides() abort
  " Make window separators the same color as normal text so they don't stand
  " out that much.
  hi link WinSeparator Normal

  " Make the Sign column the same color as the buffer.
  highlight! link SignColumn Normal

  " Fixes the unreadable HUD problem from the Conjure plugin.
  hi link NormalFloat Normal

  " Less intrusive folded lines.
  " hi Folded ctermbg=NONE ctermfg=7

  " Makes error messages readable.
  " hi ErrorMsg ctermbg=NONE ctermfg=9

  " hi Search ctermbg=3 ctermfg=0

  " hi SpellBad   ctermbg=NONE ctermfg=NONE cterm=underline
  " hi SpellRare  ctermbg=NONE ctermfg=NONE cterm=underline
  " hi SpellLocal ctermbg=NONE ctermfg=NONE cterm=underline

  " Highlight trailing whitespace.
  " hi ExtraWhitespace ctermbg=red guibg=red
  " match ExtraWhitespace /\s\+$/
endfunction

augroup ColorschemeOverrides
  autocmd!
  autocmd Colorscheme base16-default-* call s:ColorschemeOverrides()
augroup END

set notermguicolors
set bg=dark
colorscheme base16-default-dark

hi StatusLine ctermbg=10 ctermfg=12
hi statusLineNc ctermbg=10 ctermfg=14

" Reset the status line.
set statusline=
" Append the mode symbol to the status line.
set statusline+=%{mode()}
" Append the filename to the status line.
set statusline+=\ -\ %{expand('%')}
" Append cursor coordinates to the status line.
set statusline+=\ -\ %{line('.')}:%{col('.')}

set cursorline

function! SynGroup()                                                            
  let l:s = synID(line('.'), col('.'), 1)                                       

  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
