" Neovim Config
set encoding=utf-8
let mapleader=" "

" Plugin installation
call plug#begin(stdpath('data') . '/plugged')

" Code focus
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
let g:limelight_conceal_ctermfg='gray'
nnoremap <Leader>go :Goyo<CR>
augroup Goyo
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight! | hi Normal guibg=NONE ctermbg=NONE
augroup END

" File browser tree
Plug 'scrooloose/nerdtree'
nnoremap <Leader>nt :NERDTreeToggle<CR>

" Statusline
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts=1

" Theme
Plug 'dracula/vim',{'name':'dracula'}

" Better movement
Plug 'easymotion/vim-easymotion'

" Comment manipulation
Plug 'preservim/nerdcommenter'
let g:NERDSpaceDelims=1
let g:NERDCompactSexyComs=1
let g:NERDAltDelims_java=1
let g:NERDTrimTrailingWhitespace=1
let g:NERDToggleCheckAllLines=1

" Start screen when no file is opened
Plug 'mhinz/vim-startify'
let g:startify_custom_header = [
            \ '                                 __                 ',
            \ '     ___      __    ___   __  __/\_\    ___ ___     ',
            \ '   /` _ `\  /`__`\ / __`\/\ \/\ \/\ \ /` __` __`\   ',
            \ '   /\ \/\ \/\  __//\ \L\ \ \ \_/ \ \ \/\ \/\ \/\ \  ',
            \ '   \ \_\ \_\ \____\ \____/\ \___/ \ \_\ \_\ \_\ \_\ ',
            \ '    \/_/\/_/\/____/\/___/  \/__/   \/_/\/_/\/_/\/_/ '
            \ ]

" Git diffs in the gutter
Plug 'airblade/vim-gitgutter'

" Indentation guides
Plug 'yggdroot/indentline'
let g:indentLine_char='▏'
let g:indentLine_fileTypeExclude=['markdown', 'vimwiki']

" Language package
Plug 'sheerun/vim-polyglot'

" Sensible default stuff
Plug 'tpope/vim-sensible'

" Nerd Tree git integration
Plug 'xuyuanp/nerdtree-git-plugin'

" Fuzzy file finder
Plug 'kien/ctrlp.vim'

" Highlight any trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

" Automatically pair delimiters
Plug 'jiangmiao/auto-pairs'

" Icons for nerdtree and others
Plug 'ryanoasis/vim-devicons'

" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
augroup CoC
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

" Markdown tables made easier
Plug 'dhruvasagar/vim-table-mode'
let b:table_mode_corner = '|'
let b:table_mode_corner_corner = '|'
let b:table_mode_header_fillchar = '-'

" Wiki and Organization
Plug 'vimwiki/vimwiki'
let g:vimwiki_list=[{'path': '~/Documents/VimWiki/vimwiki/',
            \ 'path_html': '~/Documents/VimWiki/vimwiki_html/',
            \ 'template_path': '~/Documents/VimWiki/vimwiki/templates/',
            \ 'template_default': 'default',
            \ 'template_ext': '.html'}]

" Stop loading plugins
call plug#end()

" --------------------------------

" Override tpope's defaults
runtime! plugin/sensible.vim

" Faster command entering
nnoremap ;; ;
nnoremap ;  :

" Sidebar numbers
set number relativenumber

" Mappings to move between splits
nnoremap <Leader>wh :wincmd h<CR>
nnoremap <Leader>wl :wincmd l<CR>
nnoremap <Leader>wj :wincmd j<CR>
nnoremap <Leader>wk :wincmd k<CR>
nnoremap <Leader>w  :wincmd<space>

" Mapping to get rid of highlights from searches
nnoremap <Leader>hl :let @/=""<CR>

" Mapping to get rid of trailing whitespace
nnoremap <Leader>fw :FixWhitespace<CR>

" CoC Mappings
nnoremap <Leader>ct     :CocCommand<space>terminal.Toggle<CR>
tnoremap <Leader>ct     <C-\><C-n>:CocCommand<space>terminal.Toggle<CR>
nnoremap <Leader>rcw    :CocCommand<space>document.renameCurrentWord<CR>
nnoremap <Leader>cso    :CocList<space>outline<CR>
nnoremap <Leader>y      :<C-u>CocList -A --normal yank<CR>
nnoremap <leader>col    :CocList<CR>

" Vimwiki
augroup VimWiki
    autocmd FileType .wiki BufWritePost Vimwiki2HTML
augroup END

" Set colorscheme and background transparency
colorscheme dracula
hi Normal guibg=NONE ctermbg=NONE

" Disable putting comments on a new line
augroup NoNewlineComments
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
