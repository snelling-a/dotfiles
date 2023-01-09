if exists('g:plug_installing_plugins')

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    finish

endif

let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_experimental = 1
let g:airline_powerline_fonts = 1
let g:airline_section_x = '' " icon appears with vim-devicons
