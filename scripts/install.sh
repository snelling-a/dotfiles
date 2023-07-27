#!/usr/bin/env bash

timestamp=$(date +"%Y_%m_%d_%T")
backup_dir=$HOME/.backup_${timestamp}

backup() {
	target="$1"

	[ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$backup_dir"
}

link_file() {
	file=$(realpath "$1")
	target=${HOME}/$(basename "$1")

	backup "$target"

	ln -fnsv "$file" "$target"
}

link_dir() {
	dir=$(realpath "$1")
	target=${2:-$XDG_CONFIG_HOME}/$(basename "$1")

	ln -fnsv "$dir" "$target"
}

is_file() {
	[ -f "$1" ]
}

is_dir() {
	[ -d "$1" ]
}

create_symlinks() {
	for f in ./HOME/.* ./HOME/local/.*; do
		is_file "$f" && link_file "$f"
	done
}

link_config_directories() {
	for dir in ./config/* ./config/.local/*; do
		is_dir "$dir" && link_dir "$dir"
	done
}

check_for_backups() {
	if [ "$(ls -A "$backup_dir")" ]; then
		echo "Take action $backup_dir is not Empty"

		ls -la "$backup_dir"
	else
		rm -rf "$backup_dir"
	fi
}

brew_install() {
	if ! command -v brew >/dev/null; then
		xcode-select --install
		echo "Installing Homebrew ..."
		/bin/bash -c \
			"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

		chmod -R go-w "$(brew --prefix)/share"
	fi

	brew bundle install
}

generate_completions() {
	competion_dir="$DOTFILES/zsh/completions"

	if [ ! -d "$competion_dir" ]; then
		mkdir "$competion_dir"
	fi

	bw completion --shell=zsh >"$competion_dir/_bw"

	curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/lf.zsh -o "$competion_dir/_lf"

	gh completion -s zsh >"$competion_dir/_gh"

	glow completion zsh >"$competion_dir/_glow"

	obs completion zsh >"$competion_dir/_obs"

	wezterm shell-completion --shell zsh >"$competion_dir/_wezterm"
}

setup_wezterm() {
	tempfile=$(mktemp) &&
		curl -o "$tempfile" https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo &&
		tic -x -o ~/.terminfo "$tempfile" &&
		rm "$tempfile"

}

setup_fzf() {
	if ! command -v fzf >/dev/null; then
		/opt/homebrew/opt/fzf/install
	fi
}

setup_macos_defaults() {
	bash "$DOTFILES/scripts/macos_defaults.sh"
}

clone_notes() {
	if [ ! -d "$NOTES" ]; then
		echo "Cloning notes to $NOTES"
		git clone https://github.com/snelling-a/notes.git "$NOTES"
	fi
}

mkdir "$backup_dir"

# setup_macos_defaults
# brew_install

create_symlinks
link_config_directories

# generate_completions

# setup_wezterm
# setup_fzf

# clone_notes

check_for_backups
