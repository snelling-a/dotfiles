#!/usr/bin/env bash

wez_update() {
	brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest
}

nvim_update() {
	brew upgrade neovim --fetch-HEAD
}

git_commit_push() {
	dir="$1"
	target="$2"
	message="$3"

	git -C "$dir" add "$target"
	git -C "$dir" commit -m "chore$message"
	git -C "$dir" push
}

sudo -v

echo "Updating all the things..."

echo "Updating homebrew packages..."
brew update && brew upgrade &
wait

brew upgrade --greedy --no-quarantine &
wait

echo "Updating Neovim nightly..."
nvim_update &
wait
update_plugins && firenvim &
wait

git_commit_push "$DOTFILES/config/nvim" "$DOTFILES/config/nvim/lazy-lock.json" ": update plugins"

echo "Updating brewfile..."
brew bundle dump --force &
wait
brew bundle &
wait

echo "Cleaning up homebrew..."
brew cleanup -s &
wait

git_commit_push "$DOTFILES" "$DOTFILES/homebrew/" "(brew): update packages"

printf "\nDone!\nHappy Hacking!"
