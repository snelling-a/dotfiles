#!/usr/bin/env bash

eval "$(brew shellenv)"

PATH="/usr/local/bin/nvim:$PATH"

# use gsed as sed
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

PATH="/usr/local/opt/gawk/libexec/gnubin:$PATH"

PATH="/usr/local/bin/luacheck:$PATH"
PATH="/usr/local/bin/stylua:$PATH"

. "$HOME/.cargo/env"

# PATH="$(yarn bin):$PATH"

PATH="/usr/local/opt/curl/bin:$PATH"

PATH=/usr/local/bin:$PATH
PATH=/usr/bin/python3:$PATH

PATH="$DOTFILES/scripts:$PATH"

PATH="$HOME/go/bin:$PATH"

export PATH

# this needs to be evaluated after PATH is set
eval "$(fnm env --use-on-cd)"
