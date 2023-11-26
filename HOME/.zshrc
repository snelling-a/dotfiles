alias reload="source ~/.zshrc"
alias settings="$EDITOR ~/.zshrc && source ~/.zshrc"

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

stty sane
set -o vi
bindkey -v

setopt APPEND_HISTORY
setopt AUTOCD
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt LIST_PACKED
setopt MENU_COMPLETE
setopt PROMPT_SUBST
setopt SHARE_HISTORY

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

for file in $DOTFILES/shell/**/*.*sh; do
    [ -f $file ] && source $file
done
[ -f $HOME/.zshrc_local ] && source $HOME/.zshrc_local

source ${HOMEBREW_PREFIX:-/usr/local}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=${HOMEBREW_PREFIX:-/usr/local}/share/zsh-syntax-highlighting/highlighters
source ${HOMEBREW_PREFIX:-/usr/local}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

source ${HOMEBREW_PREFIX:-/usr/local}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${HOMEBREW_PREFIX:-/usr/local}/share/zsh-you-should-use/you-should-use.plugin.zsh
source ${HOMEBREW_PREFIX:-/usr/local}/share/zsh-autopair/autopair.zsh
