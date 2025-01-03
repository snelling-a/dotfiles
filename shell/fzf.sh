#!/usr/bin/env bash

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

fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!"
    return 1
  fi
  local file
  file="$(rg --max-count=1 --ignore-case --files-with-matches --no-messages "$*" |
    fzf-tmux +m --preview="bat --color=always {}")" && echo "opening $file" && open "$file" || return 1
}

function fcd() {
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
