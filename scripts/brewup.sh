#!/usr/bin/env bash

git_commit_push() {
  dir="$1"
  target="$2"
  message="$3"

  git -C "$dir" add "$target"
  git -C "$dir" commit -m "chore$message"
  git -C "$dir" push &
  wait
}

sudo -v

echo "Updating all the things..."

echo "Updating homebrew packages..."
brew update && brew upgrade --greedy --no-quarantine &
wait

echo "Updating brewfile..."
brew bundle dump --force &
wait
brew bundle &
wait

echo "Cleaning up homebrew..."
brew cleanup --scrub &
wait

git_commit_push "$DOTFILES" "$DOTFILES/homebrew/" "(brew): update packages"

echo "Updating yazi packages..."
ya pack --upgrade && taplo fmt "$DOTFILES/**/*.toml" --config "$DOTFILES/.taplo.toml" &

wait

git_commit_push "$DOTFILES" "$DOTFILES/config/yazi/package.toml" "(yazi): update packages"

echo "Updating Neovim plugins..."
nvim --headless "+Lazy! sync" -c quit &
wait

echo "Updating spellfile..."
nvim -e -c 'lua vim.cmd.edit(spellfile)' -c "lua require('user.autocmd').sort_spellfile()" -c quit &
wait

git_commit_push "$DOTFILES/config/nvim" "$DOTFILES/config/nvim/lazy-lock.json" ": update plugins"
git_commit_push "$DOTFILES/config/nvim" "$DOTFILES/config/nvim/spell" "(spell): update spellfile"

printf "\nDone!\nHappy Hacking!"
