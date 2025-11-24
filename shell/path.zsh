#!/usr/bin/env bash

eval "$(brew shellenv)"

PATH="$DOTFILES/scripts:$PATH"
PATH="$DOTFILES/scripts/local:$PATH"

# PATH="$HOMEBREW_PREFIX/bin/nvim:$PATH"
#
# # use gnu tools
# PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
# PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
# PATH="$HOMEBREW_PREFIX/opt/gawk/libexec/gnubin:$PATH"
# PATH="$HOMEBREW_PREFIX/opt/make/libexec/gnubin:$PATH"
# PATH="$HOMEBREW_PREFIX/opt/curl/bin:$PATH"
#
# . "$HOME/.cargo/env"
#
# PATH="$HOMEBREW_PREFIX/bin/luacheck:$PATH"
# PATH="$HOMEBREW_PREFIX/bin/stylua:$PATH"
#
# PATH="$HOMEBREW_PREFIX/python3:$PATH"
# PATH="$HOMEBREW_PREFIX/go/bin:$PATH"
# PATH="$HOMEBREW_PREFIX/opt/ruby/bin:$PATH"
# PATH="$HOMEBREW_PREFIX/opt/openjdk/bin:$PATH"

PATH="/usr/local/lib/ruby/gems/3.3.0/bin:$PATH"

eval "$(fnm env --use-on-cd)"

export PATH
