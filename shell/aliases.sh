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

alias vim="nvim"
alias update_plugins="nvim --headless \"+Lazy! sync\" +qa"

alias code="code-insiders"

dots() {
  cd "$DOTFILES" || exit
}

alias notes="cd $NOTES"
alias work="cd $WORK"

alias dcu="docker compose up"
alias dockerclean="docker system prune -af --volumes"

alias diff="delta"

alias l="lsd --long"
alias la="lsd --all"
alias lla="lsd --long --all"
alias lt="lsd --tree --depth=1 --all"
alias lta="lsd --tree --all"

alias sed="gsed"
alias awk="gawk"

alias glow='glow --config "$XDG_CONFIG_HOME/glow/glow.yml"'

alias y="yazi"

cargoup() {
  # shellcheck disable=2046 # does not work if it is double quoted
  cargo install $(cargo install --list | grep -E '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ') --force
}

alias quit_noTunes="osascript -e 'quit app \"noTunes\"'"
alias sort_launchpad="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"

export HOMEBREW_BAT=1
export HOMEBREW_BUNDLE_FILE=$DOTFILES/homebrew/Brewfile
export HOMEBREW_CASK_OPTS="--no-quarantine"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_UPGRADE_GREEDY=1
