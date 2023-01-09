if exists('g:plug_installing_plugins')

    Plug 'ryanoasis/vim-devicons'

    finish

endif

let g:DevIconsEnableFolderExtensionPatternMatching = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:webdevicons_enable = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_startify = 1

" avoid unnecessary system() calls
let g:WebDevIconsOS = 'Darwin'

if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif
