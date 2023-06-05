#!/usr/bin/env bash

# Calculate where the image should be placed on the screen.
num=$(printf "%0.f\n" "$(echo "$(tput cols) / 2" | bc)")
WIDTH=$(printf "%0.f\n" "$(echo "$(tput cols) - $num - 1" | bc)")
HEIGHT=$(printf "%0.f\n" "$(echo "$(tput lines) - 2" | bc)")

view_sqlite() {
	echo -e "# \e[1;37mTABLES\e[0m\n"
	sqlite3 "$FILE" ".tables"
	echo -e "\n# \e[1;37mSCHEMA\e[0m\n"
	sqlite3 "$FILE" ".schema"

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
}

view_sourcecode() {
	bat --color=always --style=full --decorations=always "$1" || cat "$1"
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
}

not_implemented() {
	echo "not implemented"
}

case "$1" in
*.tgz | *.tar.gz) tar tzf "$1" ;;
*.tar.bz2 | *.tbz2) tar tjf "$1" ;;
*.tar.txz | *.txz) xz --list "$1" ;;
*.tar) tar tf "$1" ;;
*.zip | *.jar | *.war | *.ear | *.oxt) unzip -l "$1" ;;
*.rar) not_implemented ;;
*.7z) not_implemented ;;
*.[1-8]) man "$1" | col -b ;;
*.o,*.torrent,*.iso,*odt,*.ods,*.odp,*.sxw,*.doc) file -i "$1" ;;
*.csv) cmd <"$1" | sed s/,/\\n/g ;;
*.bmp | *.jpg | *.jpeg | *.png | *.xpm)
	view_image "$1" || view_binary
	;;
*.wav | *.mp3 | *.m4a | *.wma | *.ape | *.ac3 | *.og[agx] | *.spx | *.opus | *.as[fx] | *.flac) not_implemented ;;
*.avi | *.mp4 | *.wmv | *.dat | *.3gp | *.ogv | *.mkv | *.mpg | *.mpeg | *.vob | *.fl[icv] | *.m2v | *.mov | *.webm | *.ts | *.mts | *.m4v | *.r[am] | *.qt | *.divx) not_implemented ;;
*) view_sourcecode "$1" ;;
esac
