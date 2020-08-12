set nocompatible
filetype plugin on
syntax on
set noswapfile

" tabs
set tabstop=4
set shiftwidth=4
set expandtab

" encodings
set encoding=utf-8
set fileencoding=utf-8

" Keep the buffers hidden when closed.
set hidden

" Plugin declarations: {{{

" Add support for python plugins.
" Python packages pynvim and neovim must be installed.
let g:python2_host_prog = exepath('python2')
let g:python3_host_prog = exepath('python3')

" Return true if any of the executables is on the $PATH.
function! s:AnyExecutable(executables) abort
    for l:exe in a:executables
        if executable(l:exe)
            return 1
        endif
    endfor
endfunction

call plug#begin('~/.config/nvim/plugged/')

" Register `vim-plug` as a plugin in order to get its documentation.
Plug 'junegunn/vim-plug'

" Text Editing {{{

" Repetition ( . ) for plugins.
Plug 'tpope/vim-repeat'

" Insert or delete brackets, parens, quotes in pair.
Plug 'jiangmiao/auto-pairs'

" Parenthesis manipulation.
Plug 'tpope/vim-surround'

" Alignment
Plug 'junegunn/vim-easy-align'

" NERD Commenter: Comment functions so powerful—no comment necessary
Plug 'scrooloose/nerdcommenter'

" Paredit like editing (s-expressions)
" Cheatsheet at: https://github.com/tpope/vim-sexp-mappings-for-regular-people
Plug 'guns/vim-sexp', { 'for': ['clojure', 'lisp', 'scheme'] }
Plug 'tpope/vim-sexp-mappings-for-regular-people',
   \ { 'for': ['clojure', 'lisp', 'scheme'] }

" Table editing, useful for markdown and latex
Plug 'dhruvasagar/vim-table-mode'

" }}}

" IDE-like features {{{

" Inellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Linter
Plug 'unc0/ale', { 'branch': 'python-support-poetry',
                 \ 'commit': '04553d34e1423da02f1e9e7ef2f7a903dcaa4f68' }
" FIXME Come back to 'w0rp/ale' once
" https://github.com/dense-analysis/ale/pull/2963 is merged.

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Documentation
if has('mac')
    Plug 'rizzatti/dash.vim'
endif

" }}}

" Programming Languages {{{

" AppleScript
if has('mac')
    Plug 'dearrrfish/vim-applescript' 
endif

" Clojure
if s:AnyExecutable(['clj', 'lein', 'boot', 'lumo'])

    " This plugin sets the 'path' for JVM languages to match the class path of
    " your current Java project. This lets commands like :find and gf work as
    " designed. I originally wrote it for Clojure, but I see no reason why it
    " wouldn't be handy for other languages as well.
    Plug 'tpope/vim-classpath', { 'for': 'clojure' }

    " Clojure nREPL support.
    Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

endif

" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'


" GLSL (OpenGL)
Plug 'tikhomirov/vim-glsl'

" HTML
Plug 'mattn/emmet-vim', { 'for': ['html', 'css']}

" JavaScript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" LaTeX
Plug 'lervag/vimtex/', {'for': ['tex', 'plaintex']}

" Ledger (Plaintext accounting)
Plug 'ledger/vim-ledger'

" Liquid
Plug 'tpope/vim-liquid'

" Markdown
Plug 'jpcenteno/checkbox.vim', {'for': 'markdown'}

" PostgreSQL
if executable('psql')
    Plug 'lifepillar/pgsql.vim'
endif

" Processing
if executable('processing-java')
    Plug 'sophacles/vim-processing'
endif

" Python
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }

" Rust
if s:AnyExecutable(['rustc', 'cargo'])
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
endif

" Typescript
if executable('tsc')
    Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
endif

" }}}

" To be sorted out: {{{

" Navigation {{{
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'
" }}}

" Aesthetic {{{

" Rainbow parens
Plug 'vim-scripts/vim-niji'

" Themes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'lifepillar/vim-solarized8'
Plug 'itchyny/lightline.vim'
Plug 'jeffkreeftmeijer/vim-dim'
" }}}

" }}}

call plug#end()
" }}}

" Navigation {{{

" Search
set ignorecase
set hlsearch

set wildignorecase " Case insensitive file globbing

set wildignore+=*/build/*   " Cmake
set wildignore+=*/target/*  " Cargo (Rust)
set wildignore+=*/plugged/* " Installed Vim plugins
set wildignore+=*.o

" Keep some lines above/below the cursor. This makes it easier to see the
" context of the line being edited.
set scrolloff=8

" simple split switching
noremap <C-j> <C-w><C-w>
noremap <C-k> <C-w>W
set splitright " always split to the right

" Open help pane to the bottom.
autocmd FileType help,man wincmd J

" Code folding
set foldenable
set foldmethod=syntax
set foldminlines=1
au FileType conf setlocal foldmethod=marker
set foldlevel=99 " unfold by default

" }}} (Navigation)

" Mappings {{{

nnoremap ; :
vnoremap ; :

let mapleader=","
let maplocalleader="-"

" Allow mouse usage on normal, visual, insert.
set mouse=nvi

" easy macroing
nmap Q @q
vmap Q :norm @q<cr>

" Copying.
nnoremap Y y$
" Copy to system clipboard
vnoremap <silent> <Leader>y "*y
vnoremap <silent> <Leader>Y "+y
" Toggle paste mode
set pastetoggle=<F10>

" ESC
if !has('nvim')
    set noesckeys " Do not wait for the esc key
endif

" no highlights
nmap <C-h> :noh<cr>

" Clear trailing whitespace from the buffer.
function! s:WhitespaceClear() abort
    let l:save_cursor = getcurpos()
    execute "%s/\\s\\s*$//g"
    call setpos('.', l:save_cursor)
endfunction
command! WhitespaceClear call s:WhitespaceClear()

" Spell Check {{{

" Check English
nmap <Leader>ce :setlocal spell spelllang=en_us<CR>

" Check Spanish
nmap <Leader>cs :setlocal spell spelllang=es_ar,en_us<CR>
nmap <Leader>cS :setlocal spell spelllang=es_ar<CR>

" Check Deutsch
nmap <Leader>cd :setlocal spell spelllang=de_de,en_us<CR>
nmap <Leader>cD :setlocal spell spelllang=de_de<CR>

" Disable spell checking
nmap <Leader>c0 :setlocal nospell<CR>

" }}}

" Show syntax highlighting groups for word under cursor {{{

function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nmap <Leader>P :call <SID>SynStack()<CR>

" }}}

" }}}

" Aesthetic {{{

" set termguicolors
" colorscheme solarized8
" set bg=light

set t_Co=16
colorscheme dim


" Better highlights for the spell checker. {{{
" augroup SpellUnderline
"
"     hi clear SpellBad
"     autocmd ColorScheme *
"         \ hi SpellBad cterm=underline ctermfg=red ctermbg=NONE
"
"     hi clear SpellCap
"     autocmd ColorScheme *
"         \ hi SpellCap cterm=underline ctermfg=blue ctermbg=NONE
"
"     hi clear SpellRare
"     autocmd ColorScheme *
"         \ hi SpellRare cterm=underline ctermfg=magenta ctermbg=NONE
"
"     hi clear SpellLocal
"     autocmd ColorScheme *
"         \ hi SpellLocal cterm=underline ctermfg=magenta ctermbg=NONE
"
" augroup END

" Underline cursor line
" hi clear CursorLine
" hi CursorLine gui=underline cterm=underline
set cursorline

" Highlight tabs and trailing spaces.
set list lcs=trail:·,tab:»\ ,extends:▶,precedes:◀

" }}} (style)
