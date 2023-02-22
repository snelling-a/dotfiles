#!/bin/bash

PATH="/usr/local/bin/nvim:$PATH"

# use gsed as sed
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
alias sed="gsed"

PATH="/usr/local/bin/luacheck:$PATH"
PATH="/usr/local/bin/stylua:$PATH"

. "$HOME/.cargo/env"

PATH=/home/$USER/.fnm:$PATH
eval "$(fnm env --use-on-cd)"

PATH="$(yarn bin):$PATH"

PATH="/usr/local/opt/curl/bin:$PATH"

PATH=/usr/local/bin:$PATH

export PATH
