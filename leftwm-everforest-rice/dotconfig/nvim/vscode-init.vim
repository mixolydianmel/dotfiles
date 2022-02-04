"""""""""""
" Plugins "
"""""""""""

call plug#begin('~/.config/nvim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdcommenter'

call plug#end()

""""""""""""
" Bindings "
""""""""""""

let mapleader = " "

nnoremap ;; ;
nnoremap ; :

nnoremap <leader>hl <cmd>noh<cr>

nnoremap <leader>wk <cmd>wincmd k<cr>
nnoremap <leader>wj <cmd>wincmd j<cr>
nnoremap <leader>wh <cmd>wincmd h<cr>
nnoremap <leader>wl <cmd>wincmd l<cr>

" UltiSnips :config
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:UltiSnipsEditSplit = "context"

""""""""""""""""
" Other Config "
""""""""""""""""

set number relativenumber

augroup NoComment
    autocmd!
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
