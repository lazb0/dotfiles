"NEOVIM CONFIG
:set number
:set autoindent
:set tabstop=2
:set shiftwidth=2
:set smarttab
:set softtabstop=2
:set mouse=a

"==VIM PLUG BEGIN==============
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'ap/vim-css-color'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'tribela/vim-transparent'
Plug 'preservim/tagbar'
Plug 'neoclide/coc.nvim'
Plug 'kkoomen/vim-doge'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'

set encoding=UTF-8

call plug#end()
"==VIM PLUG END================

"==Theme Setup=================
set termguicolors

set t_Co=256
syntax on
colorscheme minimalist

let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"==Kill NerdTree when last=====
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"==Keymaps=====================
nnoremap <C-f> :NERDTreeToggle<CR>
nnoremap <C-k> :bnext<CR>
nnoremap <C-J> :bprev<CR>

nnoremap <Leader>ev :e ~/.config/nvim/init.vim<CR>
nnoremap <Leader>sv :so ~/.config/nvim/init.vim<CR>

let mapleader = "\\"
"=AutoCompletion on TAB=======
"
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
