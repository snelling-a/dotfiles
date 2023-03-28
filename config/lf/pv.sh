#!/usr/bin/env bash

case "$1" in
*.tar*) tar tf "$1" ;;
*.zip) unzip -l "$1" ;;
*.rar) unrar l "$1" ;;
*.7z) 7z l "$1" ;;
*) bat --color=always --style=numbers --pager=never --wrap=never "$1" ;;
esac
