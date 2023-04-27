#!/usr/bin/env bash

export HIST_DIR="$HOME/.history"
mkdir -p "$HIST_DIR"

shell=$(echo "$SHELL" | cut -d'/' -f 3)
HISTFILE="$HIST_DIR/.$shell.history"

export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE

setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
