export PATH=~/.local/bin:$PATH

export DOTFILES=$HOME/dotfiles
export VIMDIR=$DOTFILES/vim
export WORK=$HOME/work

export VISUAL=vim
export EDITOR="$VISUAL"

export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

[[ -f .zshenv_local ]] && source .zshenv_local
