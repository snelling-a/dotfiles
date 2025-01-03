#!/usr/bin/env bash

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

echo "Updating brewfile..."
brew bundle dump --force &
wait
brew bundle &
wait

echo "Cleaning up homebrew..."
brew cleanup -s &
wait

git_commit_push "$DOTFILES" "$DOTFILES/homebrew/" "(brew): update packages"

echo "Updating yazi packages..."
ya pack --upgrade &
wait

git_commit_push "$DOTFILES" "$DOTFILES/yazi/package.toml" "(yazi): update packages"

echo "Updating Neovim plugins..."
nvim --headless "+Lazy! sync" -c quit &
wait

git_commit_push "$DOTFILES/config/nvim" "$DOTFILES/config/nvim/lazy-lock.json" ": update plugins"

printf "\nDone!\nHappy Hacking!"
