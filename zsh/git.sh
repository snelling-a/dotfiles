#!/bin/bash

git_log() {
	git log --perl-regexp --author='^((?!Jenkins (User)*|dependabot\[bot\]).*)$' --grep='^((?!Bump.*))' --pretty=format:'%h %Cblue%ar %Cgreen%an%Creset %s' -- "$1"

}

get_commit() {
	g log "$1" --stat -- "$2"
}
