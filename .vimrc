set nocompatible
filetype plugin indent on

syntax on

set noesckeys
set ttimeoutlen=5

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

let mapleader = " "

noremap <Leader>y "+y
noremap <Leader>p "+p

set number

set incsearch

call plug#begin()

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()

" fzf vim
nnoremap <C-p> :Files<CR>
nnoremap <C-l> :Rg<CR>
