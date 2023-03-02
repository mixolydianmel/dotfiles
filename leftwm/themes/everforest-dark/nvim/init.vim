source ~/.config/leftwm/themes/base/nvim/init.vim

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
