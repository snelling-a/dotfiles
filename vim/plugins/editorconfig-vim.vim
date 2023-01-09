
if exists('g:plug_installing_plugins')

    Plug 'editorconfig/editorconfig-vim'

    finish

endif

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_insert_final_newline = 1

au FileType gitcommit let b:EditorConfig_disable = 1
