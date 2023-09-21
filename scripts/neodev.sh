#!/usr/bin/env bash

# run this script to open neovim
# make changes and close neovim with :cquit
# neovim exits with non-zero code
# script opens neovim again

while true; do
	$(which nvim) "$@"
	if [ $? -ne 1 ]; then
		break
	fi
done
