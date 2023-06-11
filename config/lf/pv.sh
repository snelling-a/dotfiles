#!/usr/bin/env bash

set -eu

FILE="${1}"
WIDTH="${2:-$(tput cols)}"
HEIGHT="${3:-$(tput lines)}"

WIDTH="$((WIDTH - 3))"
HEIGHT="$((HEIGHT - 3))"

[ -L "${FILE}" ] && FILE="$(readlink "$FILE")"

view_sqlite() {
	echo -e "# \e[1;37mTABLES\e[0m\n"
	sqlite3 "$FILE" ".tables"
	echo -e "\n# \e[1;37mSCHEMA\e[0m\n"
	sqlite3 "$FILE" ".schema"
	return $?
}

view_image() {
	local input="${1:-$FILE}"

	viu -sb -w "$WIDTH" "$input" ||
		chafa -s "$WIDTH"x"$HEIGHT" "$input" ||
		local result=$?

	return "$result"
}

view_binary() {
	local len="$((WIDTH * HEIGHT))"

	hexyl -n "$len" --border none "$FILE" ||
		hexdump -n "$len" -C "$FILE"

	return $?
}

view_sourcecode() {
	local input="${1:-$FILE}"

	BAT_CONFIG_PATH='' bat "${input}" \
		--theme=base16 --color=always --paging=never --tabs=2 --wrap=auto \
		--style=plain --terminal-width "${WIDTH}" --line-range :"${HEIGHT}" ||
		cat "${input}"

	return $?
}

view_opendocument() {
	if ! hash pandoc 2>/dev/null; then
		odt2txt "${FILE}"
	elif ! hash glow 2>/dev/null; then
		pandoc "${FILE}" --to=markdown || odt2txt "${FILE}"
	else
		glow -s dark -w "${WIDTH}" \
			<(pandoc "${FILE}" --to=markdown || odt2txt "${FILE}")
	fi
	return $?
}

not_implemented() {
	echo "not implemented"
}

main() {
	# Display title and border
	local filename="${FILE/$PWD\//}"
	printf "\e[38;5;243m%*s\e[0m\n" $(((${#filename} + WIDTH) / 2)) "$filename"
	printf "\e[38;5;238m%${WIDTH}s\e[0m\n" | tr ' ' '-'

	case "${FILE}" in
	*.tar | *.tgz | *.xz)
		tar tvf "${FILE}"
		return $?
		;;
	*.deb)
		ar -tv "${FILE}"
		return $?
		;;
	*.zip)
		unzip -l "${FILE}"
		return $?
		;;
	*.rar)
		not_implemented
		return $?
		;;
	*.7z | *.dmg | *.gz) not_implemented ;;
	*.bzip | *.bzip2 | *.bp | *.bz2) not_implemented ;;

	*.jpg | *.JPG | *.png | *.PNG) view_image "$FILE" || view_binary ;;
	*.json) jq -C . "${FILE}" && return $? ;;
	*.md) glow -s dark -w "${WIDTH}" "${FILE}" && return $? ;;
	*.plist) plutil -p "${FILE}" && return $? ;;
	*.txt) view_sourcecode "$FILE" && return $? ;;
	esac

	case "$(file -b --mime-type "${FILE}")" in
	image/*) view_image || view_binary ;;
	application/pdf) view_binary ;;
	application/gzip | application-x-xz) tar tvf "${FILE}" ;;
	application/x-sqlite*) view_binary ;;
	application/x-terminfo | text/x-bytecode.python) view_binary ;;
	application/vnd.*-officedocument* | application/vnd.*.opendocument*)
		view_opendocument || view_binary
		;;
	application/octet-stream | application/x-*-binary | application/x-*executable)
		view_binary
		;;

	*) view_sourcecode ;;
	esac
	return $?
}

main "$FILE"
