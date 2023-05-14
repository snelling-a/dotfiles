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
	for f in ./HOME/.* ./local/.*; do
		is_file "$f" && link_file "$f"
	done
}

link_config_directories() {
	for dir in ./config/*; do
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

source_aliases() {
	if [ -f "$HOME/.zshenv" ]; then
		source "$HOME/.zshenv"
		source "$DOTFILES/zsh/aliases.sh"
	fi
	if [ -f "$HOME/.bashrc" ]; then
		source "$HOME/.bashrc"
	fi
}

brew_install() {
	if ! command -v brew >/dev/null; then
		echo "Installing Homebrew ..."
		/bin/bash -c \
			"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	brew bundle install
}

generate_completions() {
	competion_dir="$DOTFILES/zsh/completions"
	if [ ! -d "$competion_dir" ]; then
		mkdir "$competion_dir"
	fi

	wezterm shell-completion --shell zsh >"$competion_dir/_wezterm"

	bw completion --shell=zsh >"$competion_dir/_bw"

	curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/lf.zsh -o "$competion_dir/_lf"

	glow completion zsh >"$competion_dir/zsh/completions/_glow"
}

clone_notes() {
	if [ ! -d "$NOTES" ]; then
		echo "Cloning notes to $NOTES"
		git clone https://github.com/snelling-a/notes.git "$NOTES"
	fi
}

mkdir "$backup_dir"

create_symlinks

link_config_directories

source_aliases

brew_install

generate_completions

clone_notes

check_for_backups
