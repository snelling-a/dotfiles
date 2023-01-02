if exists('g:plug_installing_plugins')

    Plug 'preservim/nerdtree'  |
                \ Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

    finish

endif

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeDirArrows = 1
let NERDTreeMinimalUI = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeRespectWildIgnore=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos = "right"
let NERDTreeWinSize = 50
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeGitStatusConcealBrackets = 1
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreePatternMatchHighlightFullName = 1

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <C-t>     :NERDTreeFind<CR>

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
            \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
let g:plug_window = 'noautocmd vertical topleft new'

augroup nerdtree
    autocmd! *
        autocmd FileType nerdtree setlocal conceallevel=2
augroup END


