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

alias ga='git add'
alias gaa='git add --all'
alias gbD='git branch --delete --force'
alias gbd='git branch --delete'
alias gc='git commit --verbose'
alias gca='git commit --verbose --amend'
alias gcb='git checkout -b'
alias gcl='git clone --recurse-submodules'
alias gcm='git checkout $(git_main_branch)'
alias gcn='git commit --verbose --no-edit --amend'
alias gco='git checkout'
alias gl='git pull'
alias glg='git log --stat'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgp='git log --stat --patch'
alias glo='git log --oneline --decorate'
alias glod="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpristine='git reset --hard && git clean --force -dx'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbm='git rebase $(git_main_branch) --interactive --autosquash'
alias grbom='git rebase origin/$(git_main_branch)'
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
