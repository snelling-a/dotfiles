#!/usr/bin/env bash

DOTFILES="$HOME/dotfiles"
timestamp=$(date +"%Y_%m_%d_%T")
backup_dir=$HOME/.backup_${timestamp}

backup() {
	target="$1"

	[ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$backup_dir"
}

link_file() {
	file="$(realpath "$1")"
	target="${HOME}/$(basename "$1")"

	backup "$target"

	ln -fnsv "$file" "$target"
}

link_dir() {
	dir="$(realpath "$1")"
	target="${2:-$XDG_CONFIG_HOME}/$(basename "$1")"

	ln -Ffnsv "$dir" "$target"
}

is_file() {
	[ -f "$1" ]
}

is_dir() {
	[ -d "$1" ]
}

if ! is_dir "$DOTFILES"; then
	print "Cloning dotfiles..."
	git clone https://github.com/snelling-a/dotfiles.git --recurse-submodules "$DOTFILES"
fi

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

reset=$(tput sgr0)

check_for_backups() {
	if [ "$(ls -A "$backup_dir")" ]; then
		echo "$(tput setaf 1) Take action $backup_dir is not Empty ${reset}"

		ls -la "$backup_dir"
	else
		rm -rf "$backup_dir"
	fi
}

print() {
	printf "%s%s\n\n%s" "$(tput setaf 2)" "$1" "${reset}"
}

print "Installing dotfiles..."

brew_install() {
	print "Installing homebrew..."

	if ! command -v brew >/dev/null 2>&1; then
		xcode-select --install && sudo xcodebuild -license accept
		print "Installing Homebrew ..."
		/bin/bash -c \
			"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

		chmod -R go-w "$(brew --prefix)/share"
	fi

	print "Homebrew installed"
	print "Getting packages..."

	brew bundle install
}

generate_completions() {
	print "Generating completions..."

	if ! is_dir "$DOTFILES/zsh/completions"; then
		competion_dir="$DOTFILES/zsh/completions"
		mkdir -p "$competion_dir"

		bw completion --shell=zsh >"$competion_dir/_bw"

		curl -fsSL https://raw.githubusercontent.com/gokcehan/lf/master/etc/lf.zsh -o "$competion_dir/_lf"

		gh completion -s zsh >"$competion_dir/_gh"

		glow completion zsh >"$competion_dir/_glow"

		obs completion zsh >"$competion_dir/_obs"

		wezterm shell-completion --shell zsh >"$competion_dir/_wezterm"
	fi

	print "Completions generated"
}

setup_wezterm() {
	print "Setting up WezTerm..."

	if ! infocmp "$TERM" >/dev/null 2>&1; then
		tempfile=$(mktemp) &&
			curl -o "$tempfile" https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo &&
			tic -x -o ~/.terminfo "$tempfile" &&
			rm "$tempfile"
	fi

	print "WezTerm setup complete"
}

setup_fzf() {
	print "Setting up fzf..."

	if ! is_file "$HOME/.config/fzf/fzf"; then
		if ! command -v fzf >/dev/null 2>&1; then
			/usr/local/opt/fzf/install --xdg --key-bindings --completion --no-update-rc
		fi
	fi

	print "fzf is already setup"
}

setup_macos_defaults() {
	while true; do
		read -p "Setup macOS defaults [y/n]: " -r
		reply="${reply:-'y'}"
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			bash "$DOTFILES/scripts/macos_defaults.sh"
		elif [[ $REPLY =~ ^[Nn]$ ]]; then
			break
		fi
	done

	print
	print "macOS defaults setup complete"
}

install_cargo() {
	print "Installing cargo..."

	if ! command -v cargo >/dev/null 2>&1; then
		curl -fsSL https://sh.rustup.rs -sSf | sh
	fi
}

mkdir "$backup_dir"
mkdir -p "$HOME/work"

brew_install

create_symlinks
link_config_directories

generate_completions

install_cargo
setup_wezterm
setup_fzf

check_for_backups

setup_macos_defaults

open -a WezTerm

print "Installation complete"
print "Happy Hacking!"
