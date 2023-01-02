if exists('g:plug_installing_plugins')

    Plug 'mhinz/vim-startify'

    finish

endif

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_bookmarks = systemlist("cut -sd' ' -f 2- ~/.NERDTreeBookmarks")

let g:startify_lists = [
            \ { 'type': function('s:gitModified'),  'header': ['   git modified']   },
            \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']  },
            \ { 'type': 'dir',                      'header': ['   MRU '. getcwd()] },
            \ { 'type': 'bookmarks',                'header': ['   Bookmarks']      },
            \ ]

let g:startify_custom_header =
            \ startify#pad(split(system('figlet -cW -f starwars "==VIM=="'), '\n'))

let g:startify_change_to_dir = 0

nnoremap <leader>q :Startify<CR>
