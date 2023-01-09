" ---------------------------------------------
" Regular Vim Configuration (No Plugins Needed)
" ---------------------------------------------

" Color {{{1
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" undercurl
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

syntax enable
set termguicolors
set background=dark
colorscheme lunaperche

" UI {{{
set cmdheight=2    " Make the command area two lines high
set encoding=utf-8
set laststatus=2   " Always show the statusline
set noshowmode     " Don't show the mode since status line shows it
set nowrap         " Line wrapping off
set number         " Line numbers on
set relativenumber " Relative numbers on
set regexpengine=1 " this should make vim a bit faster, if does not work, set to 1
set ruler          " Ruler on
set shortmess+=c   " don't give |ins-completion-menu| messages
set signcolumn=number " Ensures no flickering for coc-git
set title          " Set the title of the window in the terminal to the file
set updatetime=300 " Added based on guidance from coc.nvim
set nocursorline

if exists('+colorcolumn')
    set colorcolumn=100 " Color the 100th column differently as a wrapping guide
endif
"
" Disable tooltips for hovering keywords in Vim
if exists('+ballooneval')
    set noballooneval " This doesn't seem to stop tooltips for Ruby files
    set balloondelay=100000 " 100 second delay seems to be the only way to disable the tooltips
endif

" Behaviors {{{1
filetype plugin indent on
set autoread           " Automatically reload changes if detected
set autowrite          " Writes on move/shell commands
set confirm            " Enable error files & error jumping
set fileformats=unix,mac
set formatoptions=crql
set gdefault           " this makes search/replace global by default
set hidden             " Change buffer - without saving
set history=1000       " Number of things to remember in history
set iskeyword+=\$,-    " Add extra characters that are valid parts of variables
set nobackup
set nocompatible       " be iMproved
set nostartofline      " Don't go to the start of the line after some commands
set noswapfile
set nowritebackup
set scrolloff=3        " Keep three lines below the last line when scrolling
set splitbelow
set splitright
set switchbuf=useopen  " Switch to an existing buffer if one exists
set timeoutlen=400     " Time to wait for a command (after leader for example)
set ttimeout
set ttimeoutlen=100    " Time to wait for a key sequence
set wildmenu           " Turn on WiLd menu
set wildmode=longest,full
syntax on

"change cursor to beam when in insert mode
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

if has('unnamedplus')
    set clipboard=unnamedplus,unnamed
else
    set clipboard+=unnamed
endif

" Text Format {{{1
set autoindent
set backspace=indent,eol,start " Delete everything with backspace
set cindent
set expandtab
set nospell
set shiftround
set shiftwidth=4 " Tabs under smart indent
set smarttab
set tabstop=4

" Searching {{{1
set hlsearch   " Highlight search results
set ignorecase " Case insensitive search
set incsearch  " Incremental search
set smartcase  " Non-case sensitive search
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,*.swp,*.DS_Store,*.min.*
            \.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,*.lessc,*/node_modules/*,
            \rake-pipeline-*

if has('nvim')
    set inccommand=nosplit " Preview replace as you type in nvim
endif

" Visual {{{1
set list        " Show invisible characters
set matchtime=2 " How many tenths of a second to blink
set showmatch   " Show matching brackets.

" set listchars=eol:¬
set listchars=space:\ "
set listchars+=trail:•
set listchars+=nbsp:◇
set listchars+=tab:\│\  " intentional space
set listchars+=extends:▸
set listchars+=precedes:◂

"vertical splits less gap between bars
set fillchars+=vert:│

" Sounds {{{1
set noerrorbells
set novisualbell
set t_vb=

" Mouse {{{1
set mousehide  " Hide mouse after chars typed
set mouse=a    " Mouse in all modes

" Better complete options to speed it up
set complete=.,w,b,u,U

" TODO
" let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'vim']

" TMUX {{{1

if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
    " Better mouse support, see  :help 'ttymouse'
    set ttymouse=sgr
    " Enable true colors, see  :help xterm-true-color
    let &termguicolors = v:true
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

    " Enable bracketed paste mode, see  :help xterm-bracketed-paste
    let &t_BE = "\<Esc>[?2004h"
    let &t_BD = "\<Esc>[?2004l"
    let &t_PS = "\<Esc>[200~"
    let &t_PE = "\<Esc>[201~"

    " Enable focus event tracking, see  :help xterm-focus-event
    let &t_fe = "\<Esc>[?1004h"
    let &t_fd = "\<Esc>[?1004l"
    execute "set <FocusGained>=\<Esc>[I"
    execute "set <FocusLost>=\<Esc>[O"

    " Enable modified arrow keys, see  :help arrow_modifiers
    execute "silent! set <xUp>=\<Esc>[@;*A"
    execute "silent! set <xDown>=\<Esc>[@;*B"
    execute "silent! set <xRight>=\<Esc>[@;*C"
    execute "silent! set <xLeft>=\<Esc>[@;*D"
endif
