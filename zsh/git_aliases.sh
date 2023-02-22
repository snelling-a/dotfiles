#!/bin/bash

# Functions

# Check if main exists and use instead of master
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

# Aliases
# (sorted alphabetically)
#

alias ga='git add'
alias gaa='git add --all'

alias gbd='git branch --delete'
alias gbD='git branch --delete --force'

alias gc='git commit --verbose'
alias gca='git commit --verbose --amend'
alias gcn='git commit --verbose --no-edit --amend'
alias gcb='git checkout -b'

alias gcl='git clone --recurse-submodules'
alias gpristine='git reset --hard && git clean --force -dx'
alias gcm='git checkout $(git_main_branch)'
alias gco='git checkout'
alias gcount='git shortlog --summary --numbered'
alias gcp='git cherry-pick'

alias gl='git pull'
alias glg='git log --stat'
alias glgp='git log --stat --patch'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"
alias glod="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'

alias gp='git push'
alias gpf='git push --force-with-lease'

alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbm='git rebase $(git_main_branch)'
alias grbom='git rebase origin/$(git_main_branch)'
alias groh='git reset origin/$(git_current_branch) --hard'
alias grs='git restore'

alias gst='git status'

alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'

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
