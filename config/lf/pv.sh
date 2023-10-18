#!/usr/bin/env bash

set -eu

thumbnail="/tmp/thumbnail.png"

file="${1}"
width="${2:-$(tput cols)}"
height="${3:-$(tput lines)}"

[ -L "${file}" ] && file="$(readlink "$file")"

preview() {
	local input="${1:-$file}"
	chafa "$file" -f sixel -s "$((width - 2))x$height" | sed 's/#/\n#/g' ||
		local result=$?

	return "$result"
}

view_binary() {
	local len="$((width * height))"

	hexyl -n "$len" --border none "$file" ||
		hexdump -n "$len" -C "$file"

	return $?
}

view_opendocument() {
	if ! hash pandoc 2>/dev/null; then
		odt2txt "${file}"
	elif ! hash glow 2>/dev/null; then
		pandoc "${file}" --to=markdown || odt2txt "${file}"
	else
		glow -s dark -w "${width}" \
			<(pandoc "${file}" --to=markdown || odt2txt "${file}")
	fi
	return $?
}

view_sourcecode() {
	local input="${1:-$file}"

	BAT_CONFIG_PATH='' bat "${input}" \
		--color=always \
		--number \
		--style=plain \
		--tabs=2 \
		--terminal-width "${width}" \
		--theme=base16 \
		--wrap=auto ||
		cat "${input}" || view_binary

	return $?
}

view_sqlite() {
	echo -e "# \e[1;37mTABLES\e[0m\n"
	sqlite3 "$file" ".tables"
	echo -e "\n# \e[1;37mSCHEMA\e[0m\n"
	sqlite3 "$file" ".schema"
	return $?
}

not_implemented() {
	echo "not implemented"
	file="$(readlink "$file")"
}

main() {
	case "${file}" in
	*.7z)
		7zz l "$file"
		;;
	*.avi | *.gif | *.mp4 | *.mkv | *.webm)
		not_implemented
		;;
	*.bzip | *.bzip2 | *.bp | *.bz2 | *.dmg | *.gz)
		not_implemented
		;;
	*.csv)
		csview --style=Rounded "${file}"
		;;
	*.deb)
		ar -tv "${file}"

		return $?
		;;
	*.jpg | *.JPG | *.png | *.PNG)
		preview "$file" || view_binary
		;;
	*.json*)
		sed '/^[[:blank:]]*#/d;s/\/\/.*//' "${file}" | jq --color-output . && return $?
		;;
	*.md)
		glow -s dark -w "${width}" "${file}" && return $?
		;;
	*.pdf)
		gs -o "$thumbnail" -sDEVICE=png48 -dLastPage=1 "$file" >/dev/null

		preview "$thumbnail" "$@"
		;;
	*.plist)
		plutil -p "${file}" && return $?
		;;
	*.rar)
		rar l "$file"

		return $?
		;;
	*.tar* | *.tgz | *.xz)
		tar tf "$file"
		;;
	*.txt)
		view_sourcecode "$file"
		;;
	*.zip)
		unzip -l "${file}"

		return $?
		;;
	esac

	case "$(file -b --mime-type "${file}")" in
	application/gzip | application-x-xz)
		tar tvf "${file}"
		;;
	application/octet-stream | application/x-*-binary | application/x-*executable)
		view_binary
		;;
	application/pdf)
		view_binary
		;;
	application/vnd.*-officedocument* | application/vnd.*.opendocument*)
		view_opendocument || view_binary
		;;
	application/x-sqlite*)
		view_sqlite
		;;
	application/x-terminfo | text/x-bytecode.python)
		view_binary
		;;
	image/*)
		preview || view_binary
		;;
	inode/directory | application/x-directory)
		lsd --tree --color=always --icon=always --icon-theme=fancy "$file"
		;;

	*)
		view_sourcecode
		;;
	esac

	return $?
}

main "$file"
