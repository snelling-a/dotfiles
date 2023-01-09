if exists('g:plug_installing_plugins')

    Plug 'ntpeters/vim-better-whitespace'

    finish

endif

let g:better_whitespace_enabled=1
let g:strip_whitespace_confirm=0
let g:strip_whitespace_on_save=1

let g:better_whitespace_filetypes_blacklist = [
            \'diff',
            \'fugitive',
            \'git',
            \'gitcommit',
            \'help',
            \'markdown',
            \'qf',
            \'startify',
            \'unite',
            \]

autocmd FileType markdown EnableWhitespace "  highlight whitespace in markdown files, though stripping remains disabled by the blacklist
