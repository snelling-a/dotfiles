#!/usr/bin/env bash

set -eu

thumbnail="/tmp/thumbnail.png"

file="${1}"
width="${2}"
height="${3}"

[ -L "${file}" ] && file="$(readlink "$file")"

jq_json() {
	jq --color-output . "${1}"
}

preview() {
	local input="${1:-$file}"
	chafa "$input" -f sixel -s "$((width - 2))x$height" | sed 's/#/\n#/g'
}

view_binary() {
	local len="$((width * height))"

	hexyl -n "$len" --border none "$file" ||
		hexdump -n "$len" -C "$file"
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
}

view_sqlite() {
	echo -e "# \e[1;37mTABLES\e[0m\n"
	sqlite3 "$file" ".tables"
	echo -e "\n# \e[1;37mSCHEMA\e[0m\n"
	sqlite3 "$file" ".schema"
}

not_implemented() {
	echo "not implemented"
	file="$(readlink "$file")"
}

case "$file" in
*.jpg | *.jpeg | *.png | *.bmp | *.webp)
	preview "$file" "$@"
	;;
*.7z)
	7zz l "$file"
	;;
*.avi | *.gif | *.mp4 | *.mkv | *.webm)
	not_implemented
	;;
*.csv)
	csview --style=Rounded "${file}"
	;;
*.mp3 | *.flac | *.opus)
	not_implemented
	;;
*.tar* | *.tgz | *.xz)
	tar tf "$file"
	;;
*.bzip | *.bzip2 | *.bp | *.bz2 | *.dmg | *.gz)
	not_implemented
	;;
*.deb)
	ar -tv "${file}"
	;;
*.json*)
	sed '/^[[:blank:]]*#/d;s/\/\/.*//' "${file}" | jq --color-output .
	;;
*.md)
	glow -s dark -w "${width}" "${file}"
	;;
*.pdf)
	gs -o "$thumbnail" -sDEVICE=png48 -dLastPage=1 "$file" >/dev/null
	preview "$thumbnail" "$@"
	;;
*.plist)
	plutil -p "${file}"
	;;
*.rar)
	rar l "$file"
	;;
*.svg)
	convert "$file" "$thumbnail"
	preview "$thumbnail" "$@"
	;;
*.zip)
	unzip -l "${file}"
	;;
*)
	case "$(file -b --mime-type "${file}")" in
	inode/directory | application/x-directory) lsd --tree --color=always --icon=always --icon-theme=fancy "$file" ;;
	application/gzip | application-x-xz)
		tar tvf "${file}"
		;;
	application/octet-stream | application/x-*-binary | application/x-*executable)
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
	*)
		view_sourcecode "$file"
		;;
	esac
	;;
esac

return 127 # nonzero retcode required for lf previews to reload#
