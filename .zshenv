export PATH=~/.local/bin:$PATH

export DOTFILES=$HOME/dotfiles
export VIMDIR=$DOTFILES/vim

export EDITOR=vim
export VISUAL="$EDITOR"

[[ -f $DOTFILES/.zshenv.local ]] && source $DOTFILES/.zshenv.local

