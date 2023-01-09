if exists('g:plug_installing_plugins')

    Plug 'wellle/context.vim'

    finish

endif

let g:context_presenter = 'vim-popup'
let g:context_ellipsis_char = ''

" DEFAULT AUTOCOMMANDS
autocmd VimEnter     * ContextActivate
autocmd BufAdd       * call context#update('BufAdd')
autocmd BufEnter     * call context#update('BufEnter')
autocmd CursorMoved  * call context#update('CursorMoved')
autocmd VimResized   * call context#update('VimResized')
autocmd CursorHold   * call context#update('CursorHold')
autocmd User GitGutter call context#update('GitGutter')
autocmd OptionSet number,relativenumber,numberwidth,signcolumn,tabstop,list
            \          call context#update('OptionSet')

if exists('##WinScrolled')
    autocmd WinScrolled * call context#update('WinScrolled')
endif

" DEFAULT MAPPINGS
if !exists('##WinScrolled')
    nnoremap <silent> <expr> <C-Y> context#util#map('<C-Y>')
    nnoremap <silent> <expr> <C-E> context#util#map('<C-E>')
    nnoremap <silent> <expr> zz    context#util#map('zz')
    nnoremap <silent> <expr> zb    context#util#map('zb')
endif

nnoremap <silent> <expr> zt context#util#map_zt()
nnoremap <silent> <expr> T  context#util#map_H()
