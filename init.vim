" ------------------------------------------------------------------------------
" Basic Config:
" ------------------------------------------------------------------------------

set tabstop=4 shiftwidth=4 expandtab

set noswapfile

" Keep the buffers hidden when closed.
set hidden

" Clip longer lines instead of wrapping
set nowrap

" Perform case-insensitive searches unless the search contains uppercase
" characters.
set smartcase

set completeopt=menu,menuone,noselect

set textwidth=80

set shortmess+=I " Disable intro message.

" ------------------------------------------------------------------------------
" Basic Mappings:
" ------------------------------------------------------------------------------

nnoremap <SPACE> <Nop>
let mapleader=" "

nnoremap , <Nop>
let maplocalleader=","

nnoremap ; :
vnoremap ; :

nnoremap Q @q
vnoremap Q @q

nnoremap Y y$

" Use the system clipboard register. For example, `<C-c>` with `y2y` ot copy `2`
" lines to the clipboard, `<C-c>d2d` to cut 2 lines, etc.
nnoremap <C-c> "+
vnoremap <C-c> "+

" ------------------------------------------------------------------------------
" Plugin Declarations:
" ------------------------------------------------------------------------------

lua require("config.lazy")

" ------------------------------------------------------------------------------
" Tools:
" ------------------------------------------------------------------------------

lua require("config.debug")

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
