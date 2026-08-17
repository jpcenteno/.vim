" ------------------------------------------------------------------------------
" Basic Config:
" ------------------------------------------------------------------------------

lua require("config.text").setup()

set noswapfile

" Keep the buffers hidden when closed.
set hidden

" Perform case-insensitive searches unless the search contains uppercase
" characters.
set smartcase

set completeopt=menu,menuone,noselect

" ------------------------------------------------------------------------------
" Basic Mappings:
" ------------------------------------------------------------------------------

lua require("config.keys").setup()

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

lua require("config.aesthetics").setup({})

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

hi StatusLine ctermbg=10 ctermfg=12
hi statusLineNc ctermbg=10 ctermfg=14
