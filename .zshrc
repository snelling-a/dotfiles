alias reload="source ~/.zshrc"
alias settings="$EDITOR ~/.zshrc && source ~/.zshrc"

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

for file in $DOTFILES/zsh/**/*.*sh; do
    [ -f $file ] && source $file
done

export LANG=en_US.UTF-8

stty sane
set -o vi
bindkey -v

alias vim="nvim"
alias code="codium"

export MANPAGER='nvim +Man!'
export MANWIDTH=999

alias rm="trash -v"
alias "rm -rf"="rm"
alias empty="trash -ey" # 'y' skips confirmation step

alias diff="delta"
export DELTA_FEATURES='+side-by-side'

[ -f $HOME/.zshrc_local ] && source $HOME/.zshrc_local

source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source $(brew --prefix)/share/zsh-you-should-use/you-should-use.plugin.zsh
source $(brew --prefix)/share/zsh-autopair/autopair.zsh

fpath=($DOTFILES/zsh/completions $fpath)

autoload -Uz compinit
compinit

if [[ $TERM == *-256color ]]; then
    export TERM=wezterm
fi

alias dots="cd $DOTFILES"
alias notes="cd $NOTES"
alias work="cd $WORK"
