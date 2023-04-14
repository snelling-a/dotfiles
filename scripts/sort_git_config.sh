#!/usr/bin/env bash

# GIT_CONFIG="$XDG_CONFIG_HOME/git/config"
git_config=${1:-$XDG_CONFIG_HOME/git/config}

# remove all multiple spaces
sed -E 's/\s\s+/\t/g' <"$git_config" |
	# use tab (\t) as the delimeter
	# append key to each field
	awk -F '\t' '$1 { current = $1; print current } $2 { print current "\t" $2}' |
	sort |
	# if there is only the key, print it after a new line
	# if there is a key/value pair, print the value indented
	awk -F '\t' '!$2 {print "\n"$1} $1 && $2 { print "\t" $2 }' |
	sed '1d' >output

mv output "$git_config"
