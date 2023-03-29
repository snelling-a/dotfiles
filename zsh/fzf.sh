#!/usr/bin/env bash

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

export FZF_DEFAULT_OPTS="--height=80% \
    --layout=reverse \
    --info=inline\
    --border\
    --margin=1\
    --padding=1\
    --prompt='❯ '"

# full command on preview
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

_gen_fzf_default_opts() {
	local color00='#181818'
	local color01='#282828'
	# local color02='#383838'
	# local color03='#585858'
	local color04='#b8b8b8'
	# local color05='#d8d8d8'
	local color06='#e8e8e8'
	# local color07='#f8f8f8'
	# local color08='#ab4642'
	# local color09='#dc9656'
	local color0A='#f7ca88'
	# local color0B='#a1b56c'
	local color0C='#86c1b9'
	local color0D='#7cafc2'
	# local color0E='#ba8baf'
	# local color0F='#a16946'

	export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
        --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D \
        --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C \
        --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"
}
_gen_fzf_default_opts

fif() {
	if [ ! "$#" -gt 0 ]; then
		echo "Need a string to search for!"
		return 1
	fi
	local file
	file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$*" | fzf-tmux +m --preview="rga --ignore-case --pretty --context 10 '$*' {}")" && echo "opening $file" && open "$file" || return 1
}

function cd() {
	if [[ "$#" != 0 ]]; then
		builtin cd "$@" || exit
		return
	fi
	while true; do
		lsd=$(echo ".." && lsd --almost-all | grep '/$' | sed 's;/$ ;;')
		# shellcheck disable=2016
		dir="$(printf '%s\n' "${lsd[@]}" |
			fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                dirs
                length=$(dirs | wc -c)
                printf %"$length"s |tr " " "="
                echo
                lsd --almost-all --color=always "${__cd_path}";
        ')"

		[[ ${#dir} != 0 ]] || return 0
		builtin cd "$dir" &>/dev/null || exit
	done
}
