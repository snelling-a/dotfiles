alias reload="source ~/.zshrc"
alias settings="$EDITOR ~/.zshrc && source ~/.zshrc"

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

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

for file in $DOTFILES/shell/**/*.*sh; do
	[ -f $file ] && source $file
done
[ -f $HOME/.zshrc_local ] && source $HOME/.zshrc_local

export LANG=en_US.UTF-8
export MANPAGER='nvim +Man!'
export DELTA_FEATURES='+side-by-side'

eval "$(starship init zsh)"

source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

if type brew &>/dev/null; then
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source $(brew --prefix)/share/zsh-you-should-use/you-should-use.plugin.zsh
    source $(brew --prefix)/share/zsh-autopair/autopair.zsh

	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
	FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

autoload -Uz compinit
compinit

if [[ $TERM_PROGRAM == WezTerm ]]; then
	export TERM=wezterm
fi

fzf="${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.zsh"
[ -f $fzf ] && source $fzf
