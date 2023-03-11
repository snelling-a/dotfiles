#!/usr/bin/env zsh

alias brew_list="brew info --json=v2 --installed | jq -r '.formulae[]|select(any(.installed[]; .installed_on_request)).full_name'"

alias wez_update="brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest"
export HOMEBREW_BUNDLE_FILE=$DOTFILES/homebrew/Brewfile
export HOMEBREW_NO_ANALYTICS=1

brewit() {
    # Fully manage brew installation and suppression, and then some.
    # needs zsh, jq, bat

    readonly wait_click="echo $'\n\e[34mPress any key to continue...' && read -rsk 1"
    readonly jq_all='
    (. | map(.cask_tokens) | flatten | map(split("/")[-1] + " (cask)"))[]
    , (. | map(.formula_names) | flatten)[]
    '

	readonly jq_installed='(.formulae[] | .name), (.casks[] | .token + " (cask)")'

	readonly tmp_file="$(mktemp)"
	trap "rm -f $tmp_file" EXIT

	readonly reload="reload%case \$(cat $tmp_file) in
        install) { echo Install mode; brew tap-info --json --installed | jq --raw-output '$jq_all' | sort } ;;
        *) { echo Remove mode; brew info --json=v2 --installed | jq --raw-output '$jq_installed' | sort } ;;
    esac%"

	readonly state="cat $tmp_file"

	readonly nextstate="execute-silent%case \$(cat $tmp_file) in install) echo rm > $tmp_file ;; *) echo install > $tmp_file ;; esac%"

	readonly bold="\e[1m"
	readonly reset="\e[0m"
	readonly italic="\e[3m"
	readonly gray="\e[30m"
	readonly c="\e[1;36m"
	readonly d="\e[1;37m"

	readonly help="\
    \
    ${bold}${c}[${d}B${c}]${d}rew ${c}[${d}I${c}]${d}nteractive${reset}

    ${italic}Tab${reset}     Switch between install mode and remove mode
    ${italic}Enter${reset}   Select formula or cask for installation or deletion (depends on mode)

    ${italic}ctrl-s${reset}  Show formula or cask installation [s]ource code
    ${italic}ctrl-j${reset}  Show formula or cask [J]SON information
    ${italic}ctrl-e${reset}  [E]dit formula or cask source code

    ${italic}?${reset}       Help (this page)
    ${italic}ESC${reset}     Quit


    It is also advised you use auto-updates, this can be done with:

        brew autoupdate start --upgrade --cleanup --enable-notification

    "

	echo install >"$tmp_file"

	{
		echo "Install mode (? for help)"
		brew tap-info --json --installed | jq --raw-output "$jq_all" | sort
	} |
		fzf --reverse --header-lines=1 --header-first --prompt="$ " \
			--bind="enter:execute(
                if [[ '{2}' == '(cask)' ]]; then
                    brew \$($state) --cask {1}
                else
                    brew \$($state) {1}
                fi
                $wait_click)+$reload" \
        --bind='ctrl-s:preview(
        bat --color=always $(brew edit --print-path {1}) --style=header
    )' \
        --bind="ctrl-j:preview:brew info --json=v2 {1} | jq '
                (.formulae + .casks)[0] | with_entries(select(try (.value | length > 0)))
    ' | bat --plain --language=json --color=always" \
			--bind="ctrl-e:execute:
    EDITOR='code --wait' brew edit {1}
    bat --color=always --language=markdown --plain <<-MD
                    To install the formulae (or cask) you edited with your changes, use:

                        brew reinstall --build-from-source {1}
                MD
    $wait_click" \
			--bind="tab:$nextstate+$reload" \
			--bind="?:preview:printf '$help'" \
			--preview='brew info {1} | bat --color=always --language=Markdown --style=plain' \
        --preview-window='bottom,wrap,<13(right)'

}
