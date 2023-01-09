if exists('g:plug_installing_plugins')

    Plug 'mbbill/undotree'

    finish

endif

nnoremap <F5> :UndotreeToggle<CR>

if has("persistent_undo")
    let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

let g:undotree_CursorLine = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 2
