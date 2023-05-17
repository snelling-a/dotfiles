#!/usr/bin/env bash

# Clear the last preview (if any)

# Calculate where the image should be placed on the screen.
num=$(printf "%0.f\n" "$(echo "$(tput cols) / 2" | bc)")
numb=$(printf "%0.f\n" "$(echo "$(tput cols) - $num - 1" | bc)")
numc=$(printf "%0.f\n" "$(echo "$(tput lines) - 2" | bc)")

case "$1" in
*.tgz | *.tar.gz) tar tzf "$1" ;;
*.tar.bz2 | *.tbz2) tar tjf "$1" ;;
*.tar.txz | *.txz) xz --list "$1" ;;
*.tar) tar tf "$1" ;;
*.zip | *.jar | *.war | *.ear | *.oxt) unzip -l "$1" ;;
*.rar) unrar l "$1" ;;
*.7z) 7z l "$1" ;;
*.[1-8]) man "$1" | col -b ;;
*.o,*.torrent,*.iso,*odt,*.ods,*.odp,*.sxw,*.doc) file -i "$1" ;;
#*.docx) docx2txt "$1" - ;;
*.csv) cmd <"$1" | sed s/,/\\n/g ;;
	#	*.pdf)
	#		CACHE=$(mktemp /tmp/thumbcache.XXXXX)
	#		pdftoppm -png -f 1 -singlefile "$1" "$CACHE"
	#		$HOME/.config/lf/image draw "$CACHE.png" $num 1 $numb $numc
	##		;;
#*.epub)
#	CACHE=$(mktemp /tmp/thumbcache.XXXXX)
#	epub-thumbnailer "$1" "$CACHE" 1024
#	$HOME/.config/lf/image draw "$CACHE" $num 1 $numb $numc
#	;;
*.bmp | *.jpg | *.jpeg | *.png | *.xpm)
	"$HOME"/.config/lf/image draw "$1" "$num" 1 "$numb" "$numc"
	;;
*.wav | *.mp3 | *.m4a | *.wma | *.ape | *.ac3 | *.og[agx] | *.spx | *.opus | *.as[fx] | *.flac) ;;
*.avi | *.mp4 | *.wmv | *.dat | *.3gp | *.ogv | *.mkv | *.mpg | *.mpeg | *.vob | *.fl[icv] | *.m2v | *.mov | *.webm | *.ts | *.mts | *.m4v | *.r[am] | *.qt | *.divx) ;;
*) bat --color=always --style=full --decorations=always "$1" ;;
esac
