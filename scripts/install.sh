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
	target="${2:-$XDG_CONFIG_HOME}/$3$(basename "$1")"

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

link_vimdir() {
	link_dir ./vim "$HOME" '.'
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
	if ! command -v brew >/dev/null 2>&1; then
		print "Installing homebrew..."

		xcode-select --install && sudo xcodebuild -license accept
		print "Installing Homebrew ..."

		/bin/bash -c \
			"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

		chmod -R go-w "$(brew --prefix)/share"

		print "Homebrew installed"
	fi

	print "Getting packages..."

	brew bundle install
}

generate_bash_completions() {
	print "Generating bash completions..."

	completion_dir="${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions"

	if ! is_dir completion_dir; then
		mkdir -p "$completion_dir"
	fi

	curl -fsSL https://raw.githubusercontent.com/gokcehan/lf/master/etc/lf.bash -o "$completion_dir/_lf"
	curl -fsSl https://raw.githubusercontent.com/ajeetdsouza/zoxide/master/contrib/completions/zoxide.bash -o "$completion_dir/_zoxide"
	gh completion -s bash >"$completion_dir/_gh"
	glab completion >"$completion_dir/_glab"
	glow completion bash >"$completion_dir/_glow"
	npm completion >"$completion_dir/_npm"
	obs completion bash >"$completion_dir/_obs"
	wezterm shell-completion --shell bash >"$completion_dir/_wezterm"

	print "Completions generated"
}

generate_zsh_completions() {
	print "Generating zsh completions..."

	completion_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zsh_completion"

	if ! is_dir completion_dir; then
		mkdir -p "$completion_dir"
	fi

	curl -fsSL https://raw.githubusercontent.com/gokcehan/lf/master/etc/lf.zsh -o "$completion_dir/_lf"
	gh completion -s zsh >"$completion_dir/_gh"
	glow completion zsh >"$completion_dir/_glow"
	npm completion >"$completion_dir/_npm"
	obs completion zsh >"$completion_dir/_obs"
	wezterm shell-completion --shell zsh >"$completion_dir/_wezterm"

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

	print "macOS defaults setup complete"
}

install_cargo() {
	print "Installing cargo..."

	if ! command -v cargo >/dev/null 2>&1; then
		curl -fsSL https://sh.rustup.rs -sSf | sh
	fi
}

setup_java() {
	ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
}

setup_gh() {
	gh extension install dlvhdr/gh-dash
	gh extension install seachicken/gh-poi
}

install_local() {
	is_file "$DOTFILES/shell/local/install.sh" && "$DOTFILES/shell/local/install.sh"
}

setup_vscode() {
	target="$HOME/Library/Application Support/Code - Insiders/User"

	mkdir -p "$target"
	link_file "$DOTFILES/config/vscode/*" "$target"
}

mkdir "$backup_dir"
mkdir -p "$HOME/work"

brew_install

create_symlinks
link_config_directories
link_vimdir

generate_bash_completions
generate_zsh_completions

install_cargo
setup_fzf
setup_gh
setup_java
setup_wezterm

install_local

check_for_backups

setup_macos_defaults

open -a WezTerm

print "Installation complete"
print "Happy Hacking!"
