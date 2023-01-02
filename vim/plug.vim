" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \| PlugInstall --sync | source $HOME/.vimrc
      \| endif

call plug#begin()

let g:plug_installing_plugins = 1

for file in split(glob(g:vimdir . '/plugins/*.vim'), '\n')
  exe 'source' fnameescape(file)
endfor

unlet g:plug_installing_plugins

call plug#end()

