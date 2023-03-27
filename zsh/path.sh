#!/usr/bin/env bash

PATH="/usr/local/bin/nvim:$PATH"

# use gsed as sed
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
alias sed="gsed"

PATH="/usr/local/opt/gawk/libexec/gnubin:$PATH"
alias awk="gawk"

PATH="/usr/local/bin/luacheck:$PATH"
PATH="/usr/local/bin/stylua:$PATH"

. "$HOME/.cargo/env"

# PATH="$(yarn bin):$PATH"

PATH="/usr/local/opt/curl/bin:$PATH"

PATH=/usr/local/bin:$PATH
PATH=/usr/bin/python3:$PATH

PATH="$DOTFILES/scripts:$PATH"
export PATH

eval "$(fnm env --use-on-cd)"
