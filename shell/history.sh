#!/usr/bin/env bash

export HIST_DIR="$HOME/.history"
[ -d "$HIST_DIR" ] || mkdir -p "$HIST_DIR"

shell=${SHELL##*/}
HISTFILE="$HIST_DIR/.$shell.history"

export NODE_REPL_HISTORY="$HIST_DIR/.node.history"

export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
