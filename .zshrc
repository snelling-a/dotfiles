alias settings="$EDITOR ~/.zshrc"

alias reload="source ~/.zshrc"

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

autoload -Uz compinit
compinit

export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

for file in $DOTFILES/zsh/**/*; do
    [ -f $file ] && source $file
done

export LANG=en_US.UTF-8

# ARC_BOOST_DIR=$HOME/Library/Application Support/Arc/boosts

alias dots="cd $DOTFILES"
alias vim="nvim"
alias code="codium"
export MANPAGER='nvim +Man!'
export PATH="/usr/local/bin/nvim:$PATH"

alias rm="trash -v"
alias "rm -rf"="rm"
alias empty="trash --empty -y" # 'y' skips confirmation step

alias diff="delta"
export DELTA_FEATURES='+side-by-side'

# use gsed as sed
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

export PATH="$(yarn global bin):$PATH"
[ -f $HOME/.zshrc_local ] && source $HOME/.zshrc_local
