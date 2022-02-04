"""""""""""
" Plugins "
"""""""""""

call plug#begin('~/.config/nvim/plugged')

Plug 'nvim-lua/plenary.nvim'
Plug 'sainnhe/everforest'
Plug 'neoclide/coc.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
Plug 'nvim-telescope/telescope.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'blackcauldron7/surround.nvim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'jbyuki/nabla.nvim'
Plug 'jbyuki/venn.nvim'
Plug 'vim-airline/vim-airline'
Plug 'glepnir/dashboard-nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'ervandew/supertab'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'plasticboy/vim-markdown'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'dhruvasagar/vim-table-mode'
Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdcommenter'
Plug 'OmniSharp/omnisharp-vim'
Plug 'willchao612/vim-diagon'
Plug 'jiangmiao/auto-pairs'
Plug 'jbyuki/ntangle.nvim'
Plug 'lervag/vimtex'

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

" NvimTree :bindings
nnoremap <leader>e <cmd>NvimTreeToggle<cr>

" Telescope :bindings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Floaterm :bindings
nnoremap <leader>ft <cmd>FloatermToggle<cr>

" Goyo :bindings
nnoremap <leader>go <cmd>Goyo<cr>

" Nabla :bindings
nnoremap <silent><F5> :lua require("nabla").action()<CR>
nnoremap <silent><leader>p :lua require("nabla").popup({border = rounded})<CR>

" Coc :bindings
source ~/.config/nvim/coc-conf.vim

" Venn :bindings
source ~/.config/nvim/venn-conf.vim

" Markdown :bindings
augroup Markdown
    autocmd!
    autocmd BufRead *.md nnoremap <leader>mm <cmd>MarkdownPreview<cr>
    autocmd BufRead *.md nnoremap <leader>tm <cmd>TableModeToggle<cr>
augroup END

" Vimtex :bindings
augroup Vimtex
    autocmd!
    autocmd BufRead *.tex VimtexCompile
    autocmd BufRead *.tex nnoremap <leader>nv <cmd>VimtexView<cr>
augroup END

" Groff :bindings
augroup Groff
    autocmd!
    autocmd BufRead *.ms silent set filetype=nroff
    autocmd BufRead *.ms nnoremap <silent><leader>nv <cmd>silent !zathura %:r.pdf &<cr>
    autocmd BufWritePost *.ms silent !compile %
    autocmd BufUnload *.ms silent !killall zathura
    autocmd BufRead *.ms nnoremap <silent><c-f> <cmd>silent exe "normal 0\"fy$I.PSPIC figures/"
                \ <bar> silent exe "normal A.eps"
                \ <bar> silent exe "!mkdir -p figures &&
                \ cp ~/.config/inkscape/templates/groff.svg figures/" . @f .
                \ ".svg && inkscape figures/" . @f . ".svg && inkscape figures/" . @f . 
                \ ".svg -o figures/" . @f . ".eps 
                \ --export-ps-level=3 --export-area-drawing"<cr>
augroup END

""""""""""""""""""
" Plugin Config "
"""""""""""""""""

" Treesitter :config
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
    }
}
EOF

" Floaterm :config
let g:floaterm_keymap_toggle = '<Leader>ft'

" Markdown Preview :config
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1

function MkdpBrowserCommand(address)
    execute "silent" "!surf" a:address "&"
endfunction
let g:mkdp_browserfunc='MkdpBrowserCommand'

let g:mkdp_markdown_css = '/home/caden/.config/nvim/markdown.css'
let g:mkdp_page_title = '${name}'
let g:mkdp_port = '8675'
let g:mkdp_preview_options = {
    \ 'katex': {'fleqn': 'true'},
    \ }

" Surround :config
lua require'surround'.setup{}

" Supertab :config
let g:SuperTabDefaultCompletionType = "<c-n>"

" UltiSnips :config
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:UltiSnipsEditSplit = "context"

" IndentBlankline :config
lua <<EOF
vim.opt.listchars = {
    space = "⋅",
    eol = "↴",
}

require("indent_blankline").setup {
    buftype_exclude = {"terminal", "nofile"},
    space_char_blankline = " ",
    show_current_context = true,
}
EOF

" Lightline :config
augroup Lightline
    autocmd!
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight!
augroup END
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'Gray'

" Markdown :config
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0

let g:tex_conceal = ""
let g:vim_markdown_math = 1

let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1

augroup pandoc_syntax
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
    autocmd BufRead *.md setlocal spell
    autocmd BufRead *.md set spelllang=en_us
    autocmd BufRead *.md inoremap <C-l> <Esc>[s1z=`]a
augroup END

" TableMode :config
let b:table_mode_corner = '|'
let b:table_mode_corner_corner = '|'
let b:table_mode_header_fillchar = '-'

" NerdCommenter :config
let g:NERDSpaceDelims = 1

" GitGutter :config
set signcolumn=auto

" OmniSharp :config
let g:OmniSharp_server_use_mono = 1

" NvimTree :config
lua <<EOF
    require'nvim-tree'.setup {}
EOF

" Vimtex :config
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:vimtex_syntax_conceal = {
      \ 'accents': 1,
      \ 'cites': 1,
      \ 'fancy': 1,
      \ 'greek': 1,
      \ 'math_bounds': 1,
      \ 'math_delimiters': 1,
      \ 'math_fracs': 1,
      \ 'math_super_sub': 1,
      \ 'math_symbols': 1,
      \ 'sections': 0,
      \ 'styles': 1,
      \}

"""""""""""""""""
" Other Config "
""""""""""""""""

" Colorscheme
colorscheme everforest
if has('termguicolors')
      set termguicolors
endif
set background=dark
let g:everforest_background='hard'

set cc=80

" Highlights
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE guifg=NONE
hi EndOfBuffer guibg=NONE guifg=#323d43
hi FloatermBorder guibg=NONE guifg=#d8caac

hi LineNr guibg=NONE ctermbg=NONE
hi CursorLineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi ColorColumn guibg=grey ctermbg=grey

" hi GitGutterAddLine 
" hi GitGutterChangeLine 
" hi GitGutterDeleteLine 
" hi GitGutterChangeDeleteLine 

" Other settings
set number relativenumber

augroup NoComment
    autocmd!
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
