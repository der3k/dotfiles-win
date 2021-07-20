set nocompatible
syntax on
set number

filetype on
filetype plugin on
filetype indent on

" set so=5
set smartcase
set showmatch

set path+=**

set autoread

set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8

runtime macros/matchit.vim

set backspace=indent,eol,start

set hidden

set fileformat=unix
set fileformats=unix,dos

set viminfo='100,f1

set lazyredraw
set linespace=3
set lines=999 columns=85
" winpos 0 0

" set showtabline=0

let s:ruby_path = 'C:\tools\ruby26'

" ---------------------- CUSTOMIZATION ----------------------
let mapleader = ","

" map <leader>q and <leader>w to buffer prev/next buffer
noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>
nmap <leader>tt :enew<CR>
nmap <leader>x :bd<CR>

" windows like clipboard
let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'
" map c-x and c-v to work as they do in windows, only in insert mode
vm <c-x> "+x
vm <c-c> "+y
cno <c-v> <c-r>+
exe 'ino <script> <C-V>' paste#paste_cmd['i']

" save with ctrl+s
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>

" hide unnecessary gui in gVim
if has("gui_running")
  set guioptions-=m  " remove menu bar
  set guioptions-=T  " remove toolbar
  set guioptions-=r  " remove right-hand scroll bar
  set guioptions-=L  " remove left-hand scroll bar
  set guioptions-=e
end

" set guifont=Fira_Code_Retina:h11:cANSI:qDRAFT
" set guifont=Cascadia_Code:h11:cANSI:qDRAFT
" set guifont=Menlo:h12:cANSI:qDRAFT
" set guifont=Source\ Code\ Pro\ for\ Powerline:h11:cANSI:qDRAFT
" set guifont=Source_Code_Pro_Light:h11:cANSI:qDRAFT
set guifont=JetBrains\ Mono:h11

" remove the .ext~ files, but not the swapfiles
set nobackup
set writebackup
set noswapfile

" search settings
set incsearch        " find the next match as we type the search
set hlsearch         " hilight searches by default
" use ESC to remove search higlight
nnoremap <esc> :noh<return><esc>

" suggestion for normal mode commands
set wildmode=list:longest

" keep the cursor visible within 3 lines when scrolling
set scrolloff=3

" indentation
set expandtab       " use spaces instead of tabs
set autoindent      " autoindent based on line above, works most of the time
set smartindent     " smarter indent for C-like languages
set shiftwidth=2    " when reading, tabs are 4 spaces
set softtabstop=2   " in insert mode, tabs are 4 spaces

set textwidth=80

" use <C-Space> for Vim's keyword autocomplete
"  ...in the terminal
inoremap <Nul> <C-n>
"  ...and in gui mode
inoremap <C-Space> <C-n>

set relativenumber

call plug#begin('~/vimfiles/plugged')
" Plug 'vim-scripts/L9'
" Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'jeetsukumaran/vim-buffergator'
" Plug 'tpope/vim-vinegar'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'terryma/vim-smooth-scroll'
" Plug 'tpope/vim-surround'
" Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-sensible'
" Plug 'w0rp/ale'
" Plug 'pangloss/vim-javascript'
" Plug 'zhou13/vim-easyescape'
" Plug 'jremmen/vim-ripgrep'
" Plug 'rafi/awesome-vim-colorschemes'
" Plug 'kana/vim-textobj-user'
" Plug 'kana/vim-textobj-entire'
" Plug 'kana/vim-textobj-indent'
" Plug 'kana/vim-textobj-line'
" Plug 'machakann/vim-highlightedyank'
" Plug 'tpope/vim-eunuch'
" Plug 'yalesov/vim-emblem'
" Plug 'mustache/vim-mustache-handlebars'
" Plug 'tpope/vim-repeat'
" Plug 'svermeulen/vim-easyclip'
" Plug 'editorconfig/editorconfig-vim'
" Plug 'tpope/vim-unimpaired'
" Plug 'sukima/xmledit'
" Plug 'wincent/command-t'
" Plug 'chriskempson/base16-vim'
" Plug 'prettier/vim-prettier'
" Plug 'jiangmiao/auto-pairs'
" Plug 'lfilho/cosco.vim'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install -all' }
" Plug 'junegunn/fzf.vim'
call plug#end()

nnoremap gm m

let g:highlightedyank_highlight_duration = 100

let g:easyescape_chars = { "j": 1, "k": 1 }
" let g:easyescape_timeout = 300
cnoremap jk <ESC>

set laststatus=2
set noshowmode
" let g:lightline = {
"       \ 'colorscheme': 'jellybeans'
"       \ }
let g:airline_theme = 'one'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

set wildignore=*/node_modules/*,*/tmp/*,*/dist/*,*/vendor/*,*/build/*

let g:buffergator_suppress_keymaps = 1

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
let g:netrw_altv = 1
let g:netrw_list_hide = &wildignore

nmap <leader>t :Lex<CR>
map <leader>b :BuffergatorToggle<CR>

" colorscheme materialbox
" set background=dark

set splitbelow
set splitright
" nnoremap <c-j> <c-w><c-j>
" nnoremap <c-k> <c-w><c-k>

"  Terminal escape
tnoremap <Esc> <C-\><C-n>
tnoremap <M-[> <Esc>
tnoremap <C-v><Esc> <Esc>

" Buffers switching
" Terminal mode:
tnoremap <M-h> <c-\><c-n><c-w>h
tnoremap <M-j> <c-\><c-n><c-w>j
tnoremap <M-k> <c-\><c-n><c-w>k
tnoremap <M-l> <c-\><c-n><c-w>l
" Insert mode:
inoremap <M-h> <Esc><c-w>h
inoremap <M-j> <Esc><c-w>j
inoremap <M-k> <Esc><c-w>k
inoremap <M-l> <Esc><c-w>l
" Visual mode:
vnoremap <M-h> <Esc><c-w>h
vnoremap <M-j> <Esc><c-w>j
vnoremap <M-k> <Esc><c-w>k
vnoremap <M-l> <Esc><c-w>l
" Normal mode:
nnoremap <M-h> <c-w>h
nnoremap <M-j> <c-w>j
nnoremap <M-k> <c-w>k
nnoremap <M-l> <c-w>l

autocmd BufRead,BufNewFile *.adoc,*.ad set filetype=asciidoc

if has('folding')
  if has('windows')
    let &fillchars='vert: '           " less cluttered vertical window separators
  endif
  set foldmethod=indent               " not as cool as syntax, but faster
  set foldlevelstart=99               " start unfolded
endif

" set cursorline
set ignorecase
" set foldlevelstart=2

au FileType sql setl formatprg=pg_format\ -
set list
set shortmess+=AIOTWaot
if has("gui_running")
  set termguicolors
end

set list
set listchars=nbsp:•
set listchars+=tab:>.
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=trail:•
set nojoinspaces

set nowrap
set textwidth=0
set wrapmargin=0


let g:prettier#exec_cmd_async = 1
let g:prettier#config#trailing_comma = 'none'
noremap <leader>f :PrettierAsync<cr>

:nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
