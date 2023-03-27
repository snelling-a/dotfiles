#!/usr/bin/env bash

export HIST_DIR="$HOME/.history"
mkdir -p "$HIST_DIR"

shell=$(echo "$SHELL" | cut -d'/' -f 3)
HISTFILE="$HIST_DIR/.$shell.history"

export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history
