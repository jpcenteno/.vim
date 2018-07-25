
" General {{{

" Basics
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
set fileencodings=ucs-bom,utf8,prc

" title for bash
set title
set titlestring=Vim\ -\ %t%(\ %M%)
set titleold=Terminal

" }}} (general)

" ----------------------------------------------------------------------------

" Plugins {{{

" Install Plug.vim if not present
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Coding
Plug 'vim-syntastic/syntastic' " Syntax Checking
Plug 'vim-scripts/vim-niji' " Rainbow parens
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" Web dev {{{

" Emmet: tools for easier web dev.
Plug 'mattn/emmet-vim', { 'for': ['html', 'css']}

" Javascript:
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" Typescript:
Plug 'Shougo/vimproc.vim', {'do' : 'make'} " Req for typescript
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
Plug 'Quramy/tsuquyomi', {'for': 'typescript'}

" }}}

" Navigation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'

" Lisp
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'eraserhd/parinfer-rust', { 'do': 'cargo build --release',
                               \ 'for': ['clojure', 'lisp', 'scheme']}

" Tmux integration
Plug 'sjl/tslime.vim'
Plug 'benmills/vimux'

" Python
"Plug 'vim-scripts/python.vim', { 'for': 'python' }
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }

" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Style
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'

call plug#end()

" Plugin config

" }}} (Plugins)

" ----------------------------------------------------------------------------

" Navigation {{{

" Search
set ignorecase
set hlsearch

" Scrolling
set scrolloff=8

" Splits
" simple split switching
noremap <C-j> <C-w><C-w>
noremap <C-k> <C-w>W
set splitright " split always to the right

" Code folding
set foldenable
set foldmethod=syntax
set foldminlines=1
au FileType vim setlocal foldmethod=marker
au FileType conf setlocal foldmethod=marker

" nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <Leader>n :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1
set hidden

" undo tree
nnoremap <Leader>u :UndotreeToggle<cr>:UndotreeFocus<cr>

" ctrlp
" ignores for nerdtree and ctrlp
"set wildignore+=*/static/*

" }}} (Navigation)

" ----------------------------------------------------------------------------

" Mappings {{{

" New map leader
let mapleader=","
let maplocalleader="-"

" ESC
set noesckeys " Do not wait for the esc key
map <C-space> <Esc>
imap <C-space> <Esc>
vmap <C-space> <Esc>

" Mouse
set mouse=nv

" Toggle paste mode
set pastetoggle=<F10>

" fuck shift+;
nnoremap - :
vnoremap - :
nnoremap ; :
vnoremap ; :

" easy macroing
nmap Q @q
vmap Q :norm @q<cr>

" force learning hjkl
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
"imap ^[OA <nop>
"imap ^[OB <nop>
"imap ^[OC <nop>
"imap ^[OD <nop>

" Clear unwanted whitespace.
nmap <silent> <Leader>c :%s/\s\+$//e<CR>

" Turn hilighting off
nnoremap <silent> <Leader>s :nohls<CR>

" tslime {{{
let g:tslime_ensure_trailing_newlines = 1
"let g:tslime_normal_mapping = '<localleader>t'
"let g:tslime_visual_mapping = '<localleader>t'
"let g:tslime_vars_mapping = '<localleader>T'
" }}} (tslime)

" Vimux {{{
function! VimuxSlime() " Send selection to the vimux pane
    call VimuxSendText(@v)
    "call VimuxSendKeys("Enter")
endfunction

" Send selection to repl
vmap <Leader>vs "vy :call VimuxSlime()<CR>
" Send paragraph to repl
nmap <Leader>vs vip<LocalLeader>vs<CR>
" }}}

" }}}

" ----------------------------------------------------------------------------

" Coding {{{

" Web Dev {{{

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
    au FileType javascript syntax on
augroup END

" / Web Dev }}}

" Syntastic {{{

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" C++ 11
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" / Syntastic }}}

" }}}

" ----------------------------------------------------------------------------

" Style {{{

" Color scheme
set t_Co=256 " Fix colors
set bg=dark
colorscheme dracula

" No bells
set t_vb=
set vb

" hilight current line
set cursorline

" Relative line numbers.
set relativenumber
set nu " Show the absolute line number instead of 0

" Highlight the column after textwidth
set colorcolumn=+1

" display invisible characters
exec "set listchars=tab:>\\ ,trail:\uB7,nbsp:~"
set list " See spaces

" Airline
set laststatus=2
" I prefer not to use powerline symbols in order to make the setup nicer on
" terminals with horrible fonts.

" Rainbow parens (With vim-niji) {{{
let g:niji_matching_filetypes = ['lisp', 'scheme', 'clojure']

let g:niji_dark_colours = [
    \ [ '81', '#ee4035'],
    \ [ '99', '#f37736'],
    \ [ '1',  '#fdf498'],
    \ [ '76', '#7bc043'],
    \ [ '3',  '#0392cf'],
    \ ]
" }}}

" }}} (style)

" ----------------------------------------------------------------------------

" Programming language specific {{{

""" Scheme
" see http://crash.net.nz/posts/2014/08/configuring-vim-for-sicp/
" see https://ds26gte.github.io/scmindent/index.html
" autocmd filetype lisp,scheme,art setlocal equalprg=scmindent.rkt

""" Clojure
au BufNewFile,BufRead *.boot setlocal ft=clojure

""" Typescript
au BufNewFile,BufRead *.ts setlocal ft=typescript " Typescript
let g:tsuquyomi_completion_detail = 1 " Show signature on completion

" }}}

" ----------------------------------------------------------------------------

" Legacy {{{

nnoremap Y y$
nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>
vmap <silent> <Leader>h :s/á\\|é\\|í\\|ó\\|ú\\|¡\\|ñ/\={"á": "&aacute;", "é": "&eacute;", "í": "&iacute;", "ó": "&oacute;", "ú": "&uacute;", "¡": "&iexcl;", "ñ": "&ntilde;"}[submatch(0)]/g<CR>
nmap <silent> <Leader>h :s/á\\|é\\|í\\|ó\\|ú\\|¡\\|ñ/\={"á": "&aacute;", "é": "&eacute;", "í": "&iacute;", "ó": "&oacute;", "ú": "&uacute;", "¡": "&iexcl;", "ñ": "&ntilde;"}[submatch(0)]/g<CR>


" simple yank to common buffers
vnoremap <silent> <Leader>y "*y
vnoremap <silent> <Leader>Y "+y

" }}}

" ----------------------------------------------------------------------------
