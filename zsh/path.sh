#!/usr/bin/env bash

eval "$(brew shellenv)"

PATH="/usr/local/bin/nvim:$PATH"

# use gnu tools
PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/gawk/libexec/gnubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/make/libexec/gnubin:$PATH"

PATH="$HOMEBREW_PREFIX/bin/luacheck:$PATH"
PATH="$HOMEBREW_PREFIX/bin/stylua:$PATH"

. "$HOME/.cargo/env"

# PATH="$(yarn bin):$PATH"

PATH="$HOMEBREW_PREFIX/opt/curl/bin:$PATH"

PATH=/usr/bin/python3:$PATH

PATH="$DOTFILES/scripts:$PATH"

PATH="$HOMEBREW_PREFIX/go/bin:$PATH"

export PATH

# this needs to be evaluated after PATH is set
eval "$(fnm env --use-on-cd)"
