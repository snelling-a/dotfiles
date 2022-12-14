alias settings="$EDITOR ~/.zshrc"
alias reload="source ~/.zshrc"

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="robbyrussell"
# ZSH_THEME="minima"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

ENABLE_CORRECTION="true"
# export ZSH_DISABLE_COMPFIX="true"
export ZSH_COMPDUMP_DEFAULT_DIR=$ZSH/cache/
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

# COMPLETION_WAITING_DOTS="true"

autoload -U compinit; compinit

plugins=(
    aliases
    brew
    git
    history
    history-substring-search
    macos
    node
    npm
    nvm
    you-should-use
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
    snelling-a
)

source $ZSH/oh-my-zsh.sh

export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

for file in $DOTFILES/zsh/**/*; do
    [ -f $file ] && source $file
done

# User configuration

export LANG=en_US.UTF-8

# ARC_BOOST_DIR=$HOME/Library/Application Support/Arc/boosts

alias vimrc="$EDITOR ~/.vimrc"
alias dots="cd $DOTFILES"

DISABLE_AUTO_TITLE="true"

# use gsed as sed
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

[ -f $HOME/.zshrc_local ] && source $HOME/.zshrc_local
