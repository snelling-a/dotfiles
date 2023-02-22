alias reload="source ~/.zshrc"
alias settings="$EDITOR ~/.zshrc && source ~/.zshrc"
#
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

autoload -Uz compinit
compinit

for file in $DOTFILES/zsh/**/*.*sh; do
    [ -f $file ] && source $file
done

export LANG=en_US.UTF-8


alias vim="nvim"
alias code="codium"
export MANPAGER='nvim +Man!'
export PATH="/usr/local/bin/nvim:$PATH"

alias rm="trash -v"
alias "rm -rf"="rm"
alias empty="trash --ey" # 'y' skips confirmation step

alias diff="delta"
export DELTA_FEATURES='+side-by-side'

# use gsed as sed
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
alias sed="gsed"

export PATH="$(yarn global bin):$PATH"
[ -f $HOME/.zshrc_local ] && source $HOME/.zshrc_local

source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source $(brew --prefix)/share/zsh-you-should-use/you-should-use.plugin.zsh
source $(brew --prefix)/share/zsh-autopair/autopair.zsh

source $DOTFILES/zsh/

. $(brew --prefix)/etc/profile.d/z.sh

export PATH="/usr/local/bin/luacheck:$PATH"
export PATH="/usr/local/bin/stylua:$PATH"

alias dots="cd $DOTFILES"
alias work="cd $WORK"
