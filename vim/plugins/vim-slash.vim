if exists('g:plug_installing_plugins')

    Plug 'junegunn/vim-slash'

    finish

endif

noremap <plug>(slash-after) zz

if has('timers')
    " Blink 2 times with 50ms interval
    noremap <expr> <plug>(slash-after) 'zz'.slash#blink(2, 50)
endif
