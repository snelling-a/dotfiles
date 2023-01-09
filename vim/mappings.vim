" For moving lines (^] is a special character; use <M-k> and <M-j> if it works)
inoremap ^[j <Esc>:m+<CR>==gi
inoremap ^[k <Esc>:m-2<CR>==gi
nnoremap j mz:m+<CR>`z==
nnoremap k mz:m-2<CR>`z==
vnoremap ^[j :m'>+<CR>gv=`<my`>mzgv`yo`z
vnoremap ^[k :m'<-2<CR>gv=`>my`<mzgv`yo`z

"! DON'T USE THE ARROW KEYS !"
nnoremap <up>    :echo 'NO! USE K!'<CR>
vnoremap <up>    :echo 'NO! USE K!'<CR>
nnoremap <down>  :echo 'NO! USE J!'<CR>
vnoremap <down>  :echo 'NO! USE J!'<CR>
nnoremap <left>  :echo 'NO! USE H!'<CR>
vnoremap <left>  :echo 'NO! USE H!'<CR>
nnoremap <right> :echo 'NO! USE L!'<CR>
vnoremap <right> :echo 'NO! USE L!'<CR>

" Set comma as the leader key.
" let g:mapleader = ","
let mapleader = ","
" let maplocalleader = ' '

" Press ,, to jump back to the last cursor position.
nnoremap <leader>, ``

" Type jk to exit insert mode quickly and save.
inoremap jk <Esc> :w<CR>
cnoremap jk <C-c>
" Insert mode shortcut
inoremap <C-h> <BS>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
" Bash like
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>

" Move to the start of line
nnoremap H ^
" Move to the end of line
nnoremap L $

" Don't press shift to enter command mode
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

" Center the cursor vertically
nnoremap n nzz
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" Yank from cursor to the end of line.
nnoremap Y y$

" Create newlines without entering insert mode
nnoremap go m`o<Esc>
nnoremap gO m`O<Esc>

" remap U to <C-r> for easier redo
" from http://vimbits.com/bits/356
nnoremap U <C-r>

" https://stackoverflow.com/a/53782580/14441449a
nnoremap <C-N> i<CR><Esc>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" clear highlighting
nnoremap <leader>/ :noh<CR>
