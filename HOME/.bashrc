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

shopt -s globstar nullglob dotglob
for file in "$DOTFILES"/shell/**/*".sh"; do
	source "$file"
done

eval "$(starship init bash)"
eval "$(zoxide init bash)"
