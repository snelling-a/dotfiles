#!/usr/bin/env bash

print_path() {
	tr : '\n' <<<"$PATH" | sort
}

list_env() {
	local var
	var=$(printenv | cut -d= -f1 | fzf --prompt 'env:' --preview='printenv {}') &&
		echo "$var=$(printenv "$var")" &&
		unset var
}

# pull gitignore template
gi() { curl -sLw n "https://www.toptal.com/developers/gitignore/api/$*"; }
