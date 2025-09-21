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

set cursorline

function! SynGroup()                                                            
  let l:s = synID(line('.'), col('.'), 1)                                       

  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
