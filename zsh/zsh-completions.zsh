#!/bin/zsh

if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
	FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi
