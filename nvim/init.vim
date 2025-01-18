if !exists('g:vscode')
  call plug#begin('~/vimfiles/plugged')
  Plug 'tpope/vim-sensible'
  Plug 'ur4ltz/surround.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'lewis6991/spellsitter.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  " Plug 'neovim/nvim-lspconfig'
  " Plug 'hrsh7th/cmp-nvim-lsp'
  " Plug 'williamboman/mason.nvim'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'
  " Plug 'akinsho/toggleterm.nvim'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'joshdick/onedark.vim'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
  Plug 'ggandor/leap.nvim'
  call plug#end()
else
  call plug#begin('~/vimfiles/plugged')
  Plug 'tpope/vim-sensible'
  Plug 'blackcauldron7/surround.nvim'
"  Plug 'hrsh7th/cmp-buffer'
"  Plug 'hrsh7th/nvim-cmp'
"  Plug 'michaeljsmith/vim-indent-object'
"  Plug 'asvetliakov/vim-easymotion'
  call plug#end()
endif

" apply vim-sensible settings to be able to override it
runtime plugin/sensible.vim

" use windows clipboard
let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'

let mapleader=' '

" save with ctrl+s
nmap <c-s> :w<cr>
imap <c-s> <esc>:w<cr>

nmap <leader>x :bd<cr>
nmap <esc> :nohlsearch<cr>

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

nmap s <Plug>(easymotion-s)

if !exists('g:vscode')
  " Find files using Telescope command-line sugar.
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
  nnoremap <leader>. <cmd>Telescope spell_suggest<cr>
endif

set smartcase
set ignorecase

set expandtab
set autoindent
set smartindent
set shiftwidth=2
set softtabstop=2

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99

let g:surround_mappings_style = 'surround'
lua require"surround".setup{}

set number
set relativenumber

set wrap
set breakindent
set breakindentopt=shift:0
set showbreak=↪\ 

nmap j gj
nmap k gk

nnoremap <c-j> :m+<cr>
nnoremap <c-k> :m-2<cr>

nmap <leader>j <c-d>
nmap <leader>k <c-u>
vmap <leader>j <c-d>
vmap <leader>k <c-u>

set completeopt=menu,menuone

if exists('g:started_by_firenvim')
  set noshowmode
  set noruler
  set laststatus=0
  set noshowcmd
  set cmdheight=1
  set nonumber
  set norelativenumber
  inoremap <c-cr> <esc>:wq<cr>
  nnoremap <c-cr> :wq<cr>
  autocmd BufRead,BufNewFile * start
endif

autocmd TextYankPost * silent! lua vim.highlight.on_yank()

if !exists('g:vscode')
colorscheme onedark
set guifont=JetBrainsMono\ Nerd\ Font:h14

if !exists('g:started_by_firenvim')
lua <<EOF
require'nvim-web-devicons'.setup {
 default = true;
}
EOF

lua <<EOF
require'nvim-tree'.setup {
}
EOF

lua <<EOF
require('lualine').setup()
EOF
endif

lua <<EOF
require('spellsitter').setup()
EOF

nmap <leader>t :NvimTreeToggle<cr>
nmap <leader>, :e $MYVIMRC<cr>

set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set list

setlocal spell spelllang=en_us

lua <<EOF
require('leap').set_default_keymaps()
EOF

endif

if exists('g:vscode')
  nnoremap zM :call VSCodeNotify('editor.foldAll')<CR>
  nnoremap zR :call VSCodeNotify('editor.unfoldAll')<CR>
  nnoremap zc :call VSCodeNotify('editor.fold')<CR>
  nnoremap zC :call VSCodeNotify('editor.foldRecursively')<CR>
  nnoremap zo :call VSCodeNotify('editor.unfold')<CR>
  nnoremap zO :call VSCodeNotify('editor.unfoldRecursively')<CR>
  nnoremap za :call VSCodeNotify('editor.toggleFold')<CR>
endif

if exists('g:nvui')
  NvuiCmdTopPos 0.9
  NvuiCmdLeftPos 0.05
  NvuiCmdWidth 0.9
  NvuiCmdFontSize 15.0
endif
