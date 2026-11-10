#!/usr/bin/env bash

eval "$(brew shellenv)"

PATH="$DOTFILES/scripts:$PATH"
PATH="$DOTFILES/scripts/local:$PATH"

# PATH="$HOMEBREW_PREFIX/bin/nvim:$PATH"
PATH="$HOMEBREW_PREFIX/opt/make/libexec/gnubin:$PATH"
PATH="$HOMEBREW_PREFIX/opt/curl/bin:$PATH"

PATH="/usr/local/lib/ruby/gems/3.3.0/bin:$PATH"

PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

export PATH
