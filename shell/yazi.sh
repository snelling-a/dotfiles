#!/usr/bin/env bash

function y() {
	local tmp
	tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	$tmp cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd" || exit
	fi
	rm -f -- "$tmp"
}
