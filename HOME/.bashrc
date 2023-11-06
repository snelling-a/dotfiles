#!/usr/bin/env bash

export BASH_SILENCE_DEPRECATION_WARNING=1

if [ -f "$HOME/.zshenv" ]; then
	source "$HOME/.zshenv"
fi

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

shopt -s globstar nullglob dotglob
for file in "$DOTFILES"/shell/**/*".sh"; do
	source "$file"
done

eval "$(starship init bash)"
eval "$(zoxide init bash)"
