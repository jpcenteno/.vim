" Aliases for the colors defined by the terminal emulator color base-16 theme.
"
" The mappings were taken from https://github.com/chriskempson/base16-vim/blob/master/templates/default.mustache#L56
" The semantic guidelines were taken from https://github.com/tinted-theming/home/blob/main/styling.md
let s:base00 = 0  " Black (Background) Default Background
let s:base01 = 10  " (Darkest Gray) Lighter Background (Used for status bars)
let s:base02 = 11  " (Dark Gray) Selection Background
let s:base03 = 8  " Bright Black (Gray) Comments, Invisibles, Line Highlighting
let s:base04 = 12  " (Light Gray) Dark Foreground (Used for status bars)
let s:base05 = 7  " Foreground Default Foreground, Caret, Delimiters, Operators
let s:base06 = 13  " White Light Foreground
let s:base07 = 15  " Bright White The Lightest Foreground
let s:base08 = 1  " (1 and 9) Red and Bright Red Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
let s:base09 = 9  " (Orange) Integers, Boolean, Constants, XML Attributes, Markup Link Url
let s:base0A = 3  " (3 and 11) Yellow and Bright Yellow Classes, Markup Bold, Search Text Background
let s:base0B = 2  " (2 and 10) Green and Bright Green Strings, Inherited Class, Markup Code, Diff Inserted
let s:base0C = 6  " (6 and 14) Cyan and Bright Cyan Support, Regular Expressions, Escape Characters, Markup Quotes
let s:base0D = 4  " (4 and 12) Blue and Bright Blue Functions, Methods, Attribute IDs, Headings
let s:base0E = 5  " (5 and 13) Purple and Bright Purple Keywords, Storage, Selector, Markup Italic, Diff Changed
let s:base0F = 14  " (Dark Red or Brown) Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>

" Semantic colors
let s:default_bg = s:base00
let s:default_fg = s:base05
let s:lighter_bg = s:base01
let s:status_bar_bg = s:base01
let s:status_bar_fg = s:base04
let s:selection_bg = s:base02
let s:selection_fg = s:base07
let s:lightest_fg = s:base06
let s:darkest_gray = s:base01
let s:search_text_bg = s:base0A
let s:comment_fg = s:base03
let s:markup_bold = s:base0A
let s:markup_italic = s:base0E

function! <sid>hi(group, fg, bg, style)
  execute 'highlight' a:group
        \ 'ctermfg=' . a:fg
        \ 'ctermbg=' . a:bg
        \ 'cterm='   . a:style
endfunction

function! s:base16_colorscheme_enhancements() abort
  " == General text highlighting ==
  call <sid>hi("Comment", s:comment_fg, s:default_bg, "italic")


  " == General layout ==

  call <sid>hi("Folded", s:comment_fg, s:default_bg, "italic")
  call <sid>hi("WinSeparator", s:darkest_gray, s:default_bg, "none")

  " This fixes the unreadable HUD problem from the Conjure plugin.
  hi link NormalFloat Pmenu

  " == Popup menu, autocomplete menu ==

  call <sid>hi("Pmenu", s:status_bar_fg, s:status_bar_bg, "none")
  call <sid>hi("PmenuSel", s:selection_fg, s:selection_bg, "bold")
  hi link PmenuSbar Pmenu

  " Text styled using markup.
  " Note: Markdown highlight groups should link to the HTML ones.
  call <sid>hi("HtmlBold", s:markup_bold, "NONE", "bold")
  call <sid>hi("HtmlItalic", s:markup_italic, "NONE", "italic")
endfunction

augroup Base16ColorschemeEnhancements
  autocmd!
  autocmd Colorscheme base16-default-* call s:base16_colorscheme_enhancements()
augroup END

" `g:colors_name` can be undefined if `colorscheme ...` has not been called
" before this script.
let s:colors_name = get(g:, 'colors_name', 'default')

if s:colors_name ==# 'base16-default-light' || s:colors_name ==# 'base16-default-dark'
  call s:base16_colorscheme_enhancements()
endif
