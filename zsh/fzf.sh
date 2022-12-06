[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export FZF_DEFAULT_COMMAND='fd --type f'

export FZF_DEFAULT_OPTS="--height=80% --layout=reverse --info=inline --border --margin=1 --padding=1"

# full command on preview
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# preview the entries of the directory
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
# interactive cd  https://github.com/junegunn/fzf/wiki/Examples#interactive-cd
function cd() {
  if [[ "$#" != 0 ]]; then
    builtin cd "$@";
    return
  fi
  while true; do
    local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
    local dir="$(printf '%s\n' "${lsd[@]}" |
      fzf --reverse --preview '
          __cd_nxt="$(echo {})";
          __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
          echo $__cd_path;
          echo;
          # ls -p --color=always "${__cd_path}";
          ls -p -FG "${__cd_path}";
          ')"
          [[ ${#dir} != 0 ]] || return 0
          builtin cd "$dir" &> /dev/null
        done
      }

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}
