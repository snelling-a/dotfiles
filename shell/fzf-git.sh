#!/usr/bin/env bash

# fshow - git commit browser
fshow() {
	git log --graph --color=always \
		--format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
		fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
			--bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
	local out q k sha
	while out=$(
		git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
			fzf --ansi --no-sort --query="$q" --print-query \
				--expect=ctrl-d,ctrl-b
	); do
		mapfile -t out <<<"$out"
		q="${out[0]}"
		k="${out[1]}"
		sha="${out[-1]}"
		sha="${sha%% *}"
		[[ -z "$sha" ]] && continue
		if [[ "$k" == 'ctrl-d' ]]; then
			git diff "$sha"
		elif [[ "$k" == 'ctrl-b' ]]; then
			git stash branch "stash-$sha" "$sha"
			break
		else
			git stash show -p "$sha"
		fi
	done
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbranch() {
	local branches branch
	branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
		branch=$(echo "$branches" |
			fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
		git checkout "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
}

# fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco() {
	local branches target

	branches=$(
		git --no-pager branch --all \
			--format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" |
			sed '/^$/d'
	) || return

	target=$(
		(echo "$branches") |
			fzf --no-hscroll \
				--no-multi \
				-n 2 \
				--ansi \
				--preview="git --no-pager log -150 --pretty=format:%s '..{2}'"
	) || return

	git checkout "$(awk '{print $2}' <<<"$target")"
}
