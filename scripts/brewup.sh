#!/usr/bin/env bash

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
nvim --headless '+GenerateAverageColor' "+Lazy! sync" "+MasonUpdateAll" -c "call firenvim#install(0)" -c quit &
wait

git_commit_push "$DOTFILES/config/nvim" "$DOTFILES/config/nvim/lazy-lock.json" ": update plugins"
git_commit_push "$DOTFILES/config/nvim" "$DOTFILES/config/nvim/colors/average_dark.lua" ": update AverageDark colorscheme"

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
