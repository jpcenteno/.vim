
" General {{{

" Basics
set nocompatible
filetype plugin on
syntax on

" encodings
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc

" Code folding
set foldenable
set foldmethod=syntax
au FileType vim setlocal foldmethod=marker
au FileType conf setlocal foldmethod=marker

" }}} (general)

" Mappings {{{

" New map leader
let mapleader=","
let maplocalleader="-"

" Do not wait for the esc key
set noesckeys

" Mouse
set mouse=nv

" Toggle paste mode
set pastetoggle=<F10>

" fuck shift+;
nnoremap - :
vnoremap - :
nnoremap ; :
vnoremap ; :

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

" Clear a line
nmap <silent> <Leader>c 0d$

" Turn hilighting off
nnoremap <silent> <Leader>s :nohls<CR>

" Move to the next "empty set symbol" (alt-o)
nnoremap <C-a><C-a> /ø<Enter>:nohls<Enter>"_cl
inoremap <C-a><C-a> <Esc>/ø<Enter>:nohls<Enter>"_cl

" tslime {{{
let g:tslime_ensure_trailing_newlines = 1
"let g:tslime_normal_mapping = '<localleader>t'
"let g:tslime_visual_mapping = '<localleader>t'
"let g:tslime_vars_mapping = '<localleader>T'
" }}} (tslime)

" }}}

" Plugins {{{
call plug#begin('~/.vim/plugged')

" Coding
Plug 'vim-syntastic/syntastic' " Syntax Checking
Plug 'vim-scripts/vim-niji' " Rainbow parens
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" Web dev
Plug 'mattn/emmet-vim', { 'for': ['html', 'css']}
Plug 'Shougo/vimproc.vim', {'do' : 'make'} " Req for typescript
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
Plug 'Quramy/tsuquyomi', {'for': 'typescript'}

" Navigation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'

" Lisp
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"Plug 'bhurlow/vim-parinfer', { 'for': ['clojure', 'scheme'] }
Plug 'kovisoft/paredit', { 'for': ['clojure', 'scheme'] }
Plug 'sjl/tslime.vim'

" Python
"Plug 'vim-scripts/python.vim', { 'for': 'python' }
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }

" Style
Plug 'dracula/vim' " Dracula theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" Plugin config

" ctrlp
nnoremap <C-b> :CtrlPBuffer<CR>

" nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <Leader>n :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1
set hidden

" undo tree
nnoremap <Leader>u :UndotreeToggle<cr>:UndotreeFocus<cr>

" ignores for nerdtree and ctrlp
"set wildignore+=*/static/*

" }}} (Plugins)

" Style {{{

" Color scheme
set t_Co=256 " Fix colors
set bg=dark
colorscheme dracula

" hilight current line
set cursorline

" Relative line numbers.
set relativenumber
set nu " Show the absolute line number instead of 0

" GUI Options (Ezequiel wrote it. I don't use it)
"au GUIEnter * simalt ~x
"set guifont=Source_Code_Pro_Light:h10:cANSI
"set guioptions=egrLt

" Highlight chars after column 80
match ErrorMsg '\%>80v.\+'

" Airline {{{
" I don't use the powerline symbols because I want my vim config to be
" compatible with every terminal that does not have them.
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='base16_default'
" }}}

" Rainbow parens (With vim-niji) {{{
let g:niji_dark_colours = [
    \ [ '81', '#ee4035'],
    \ [ '99', '#f37736'],
    \ [ '1',  '#fdf498'],
    \ [ '76', '#7bc043'],
    \ [ '3',  '#0392cf'],
    \ ]
" }}}

" }}} (style)

" Programming language specific {{{

" Scheme
" see http://crash.net.nz/posts/2014/08/configuring-vim-for-sicp/
" see https://ds26gte.github.io/scmindent/index.html
" autocmd filetype lisp,scheme,art setlocal equalprg=scmindent.rkt

" Clojure
au BufNewFile,BufRead *.boot setlocal ft=clojure " Boot config files are clojure

" Typescript
au BufNewFile,BufRead *.ts setlocal ft=typescript " Typescript
let g:tsuquyomi_completion_detail = 1 " Show signature on completion

" }}}

" Legacy {{{
set ignorecase
set tabstop=4
set shiftwidth=4
set expandtab
set scrolloff=8
set noswapfile
set foldminlines=4
set splitright " split always to the right

set t_vb=
set vb
set hlsearch

" the mappings
map <C-space> <Esc>
imap <C-space> <Esc>
vmap <C-space> <Esc>

"nmap <tab> :tabnext<CR>
"nmap <S-tab> :tabprevious<CR>
"nmap <F8> :TagbarToggle<CR>
nnoremap Y y$
"noremap º ^
nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>
vmap <silent> <Leader>h :s/á\\|é\\|í\\|ó\\|ú\\|¡\\|ñ/\={"á": "&aacute;", "é": "&eacute;", "í": "&iacute;", "ó": "&oacute;", "ú": "&uacute;", "¡": "&iexcl;", "ñ": "&ntilde;"}[submatch(0)]/g<CR>
nmap <silent> <Leader>h :s/á\\|é\\|í\\|ó\\|ú\\|¡\\|ñ/\={"á": "&aacute;", "é": "&eacute;", "í": "&iacute;", "ó": "&oacute;", "ú": "&uacute;", "¡": "&iexcl;", "ñ": "&ntilde;"}[submatch(0)]/g<CR>
"super diff para cuando cambia el archivo
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" displays invisible characters
exec "set listchars=tab:>\\ ,trail:\uB7,nbsp:~"
set list
nnoremap <silent> <Leader>p :set list!<CR>


" title for bash
set title
set titlestring=Vim\ -\ %t%(\ %M%)
set titleold=Terminal

" easy macroing
"nnoremap Q @q
"vnoremap Q :norm @q<cr>

" simple split switching
"noremap <C-j> <C-w><C-w>
"noremap <C-k> <C-w>W

" simple yank to common buffers
vnoremap <silent> <Leader>y "*y
vnoremap <silent> <Leader>Y "+y

" python dbg
" nnoremap <silent> <Leader>d Oimport ipdb;ipdb.set_trace()<Esc>

" Syntastic settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" }}}
