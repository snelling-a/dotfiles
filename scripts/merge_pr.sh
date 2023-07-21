#!/usr/bin/env bash

pr_number="$1"

[ -z "$pr_number" ] && pr_number=$(gh pr list | fzf | gawk '{print $1}')
[ -z "$pr_number" ] && exit 1

gh pr merge --delete-branch --admin --squash "$pr_number"

git pull
