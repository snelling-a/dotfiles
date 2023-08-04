#!/usr/bin/env bash

print_path() {
	tr : '\n' <<<"$PATH" | sort
}

# pull gitignore template
gi() { curl -sLw n "https://www.toptal.com/developers/gitignore/api/$*"; }
