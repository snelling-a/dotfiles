#!/usr/bin/env bash

git_log() {
	git log --perl-regexp --author='^((?!Jenkins (User)*|dependabot\[bot\]).*)$' --grep='^((?!Bump.*))' --pretty=format:'%h %Cblue%ar %Cgreen%an%Creset %s' -- "$1"
}

get_commit() {
	git log "$1" --stat -- "$2"
}

git_main_branch() {
	command git rev-parse --git-dir &>/dev/null || return
	local ref
	for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default}; do
		if command git show-ref -q --verify "$ref"; then
			echo "${ref:t}"
			return
		fi
	done
	echo master
}

function grename() {
	if [[ -z "$1" || -z "$2" ]]; then
		echo "Usage: $0 old_branch new_branch"
		return 1
	fi

	# Rename branch locally
	git branch -m "$1" "$2"
	# Rename branch in origin remote
	if git push origin :"$1"; then
		git push --set-upstream origin "$2"
	fi
}

alias gcm='git checkout $(git_main_branch)'
alias grbm='git rebase $(git_main_branch) --interactive --autosquash'
alias gst='lazygit'
