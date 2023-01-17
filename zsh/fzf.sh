[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_COMMAND='fd --type f --follow --hidden'

export FZF_DEFAULT_OPTS="--height=80% --layout=reverse --info=inline --border --margin=1 --padding=1"

# full command on preview
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# preview the entries of the directory
TREE_PREVIEW="($TREE --level=1 || tree -C {}) | head -200"
export FZF_ALT_C_OPTS="--preview '$TREE_PREVIEW'"
# interactive cd  https://github.com/junegunn/fzf/wiki/Examples#interactive-cd
function cd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview $TREE_PREVIEW'
                    __cd_nxt="$(echo {})";
                    __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                    echo $__cd_path;
                    echo;
                    '$TREE' "${__cd_path}";
                    ')"
                    [[ ${#dir} != 0 ]] || return 0
                    builtin cd "$dir" &> /dev/null
                done
            }

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    rg --color=always --line-number --no-heading --smart-case "${*:-}" |
    fzf --ansi \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
}
