#!/usr/bin/env bash

export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS \
    --preview 'lsd --color=always \
    --group-directories-first \
    --oneline {2..}'"

LAST_REPO=""
__zoxide_z() {
	if [ "$#" -eq 0 ]; then
		__zoxide_cd ~
	elif [ "$#" -eq 1 ] && [ "$1" = '-' ]; then
		if [ -n "${OLDPWD}" ]; then
			__zoxide_cd "${OLDPWD}"
		else
			\builtin printf 'zoxide: %s is not set' "$OLDPWD"
			return 1
		fi
	elif [ "$#" -eq 1 ] && [ -d "$1" ]; then
		__zoxide_cd "$1"
	else
		\builtin local result
		result="$(zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" &&
			__zoxide_cd "${result}"
	fi

	if [[ -f .node-version || -f .nvmrc ]]; then
		fnm use --silent-if-unchanged
	fi

	if git rev-parse 2>/dev/null; then
		if [ "$LAST_REPO" != "$(basename "$(git rev-parse --show-toplevel)")" ]; then
			onefetch
			LAST_REPO=$(basename "$(git rev-parse --show-toplevel)")
		fi
	fi
}
