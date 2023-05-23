#!/usr/bin/env bash
# the aliases use variables that won't change
# shellcheck disable=2139

alias cd..='cd ..'

alias ..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias ~='cd ~'

alias h='history'

alias vim_stable="NVIM_APPNAME=neovim nvim"
alias vim="nvim"
alias code="codium"

alias rm="trash -v"
alias "rm -rf"="rm"
alias empty="trash -ey" # 'y' skips confirmation step

alias dots="cd $DOTFILES"
alias notes="cd $NOTES"
alias work="cd $WORK"
alias dockerclean="docker system prune -af --volumes"
alias diff="delta"

alias ls='lsd'

alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree --all'
alias lt1='ls --tree --depth=1'

alias sed="gsed"
alias awk="gawk"

alias glow='glow --config "$XDG_CONFIG_HOME/glow/glow.yml"'

alias ctags="$HOMEBREW_PREFIX/bin/ctags"

cargoup() {
	# shellcheck disable=2046 # does not work if it is double quoted
	cargo install $(cargo install --list | grep -E '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ') --force
}

alias brew_list="brew info --json=v2 --installed | jq -r '.formulae[]|select(any(.installed[]; .installed_on_request)).full_name'"

alias wez_update="brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest"
alias nvim_update="brew upgrade neovim --fetch-HEAD"

alias brewup="brew update \
    && brew upgrade \
    && wez_update \
    && nvim_update \
    && brew bundle dump --force \
    && brew bundle \
    && brew cleanup"

export HOMEBREW_BUNDLE_FILE=$DOTFILES/homebrew/Brewfile
export HOMEBREW_NO_ANALYTICS=1
