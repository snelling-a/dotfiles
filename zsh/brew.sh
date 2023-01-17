#!/bin/bash

alias brew_list="brew info --json=v2 --installed | jq -r '.formulae[]|select(any(.installed[]; .installed_on_request)).full_name'"

# Add Homebrew's executable directory to the front of the PATH
export PATH=/usr/local/bin:$PATH

export HOMEBREW_NO_ANALYTICS=1

