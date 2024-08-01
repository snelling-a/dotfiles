#!/usr/bin/env bash

export BASH_SILENCE_DEPRECATION_WARNING=1

if [ -f "$HOME/.zshenv" ]; then
	source "$HOME/.zshenv"
fi

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

set -o vi

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
bind '"\e[Z": menu-complete-backward'
bind "set menu-complete-display-prefix on"
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

eval "$(fzf --bash)"
eval "$(starship init bash)"
eval "$(zoxide init bash)"

export HISTCONTROL="erasedupes"

shopt -s globstar nullglob dotglob
for file in "$DOTFILES"/shell/**/*".sh"; do
	source "$file"
done

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
