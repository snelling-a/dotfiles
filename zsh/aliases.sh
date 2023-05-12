#!/usr/bin/env bash
# the aliases use variables that won't change
# shellcheck disable=2139

alias cd..='cd ..'

alias ..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias ~='cd ~'

alias h='history'

alias vim_stable="NVIM_APPNAME=neovim nvim"
alias vim="nvim"
alias code="codium"

alias rm="trash -v"
alias "rm -rf"="rm"
alias empty="trash -ey" # 'y' skips confirmation step

alias dots="cd $DOTFILES"
alias notes="cd $NOTES"
alias work="cd $WORK"
alias dockerclean="docker system prune -af --volumes"
alias diff="delta"
