#!/usr/bin/env bash
set -euo pipefail

: "${DOTFILES:?DOTFILES env var not set}"
: "${HOMEBREW_BUNDLE_FILE:?HOMEBREW_BUNDLE_FILE env var not set}"

# @param dir directory of the git repo
# @param target file or directory to add/commit/push
# @param message commit message suffix
git_commit_push() {
  local dir="$1" target="$2" message="$3"
  git -C "$dir" add "$target"
  if ! git -C "$dir" diff --cached --quiet; then
    git -C "$dir" commit -m "chore$message"
    git -C "$dir" push
  else
    echo "Nothing to commit in $target"
  fi
}

sudo -v
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

echo "Updating Homebrew..."
brew update

echo "Checking for outdated formulae..."
if [[ -n "$(brew outdated --formula)" ]]; then
  echo "Upgrading formulae..."
  brew upgrade --fetch-HEAD
else
  echo "Formulae up to date."
fi

echo "Checking for outdated casks..."
if [[ -n "$(brew outdated --cask --greedy)" ]]; then
  echo "Upgrading casks..."
  brew upgrade --cask --greedy 2>&1 |
    awk '!/Not upgrading .*installer manual/ && !/^[[:space:]]*[[:alnum:]_\-]+$/' || true
else
  echo "Casks up to date."
fi

echo "Cleaning up..."
brew autoremove
brew cleanup --prune=30 --scrub
echo "Homebrew fully updated."

TMP_BUNDLE=$(mktemp)
brew bundle dump --force --describe --file="$TMP_BUNDLE"

if ! cmp -s "$TMP_BUNDLE" "$HOMEBREW_BUNDLE_FILE"; then
  echo "Updating Brewfile..."
  cp "$HOMEBREW_BUNDLE_FILE" \
    "$HOMEBREW_BUNDLE_FILE.bak.$(date +%Y%m%d-%H%M%S)" 2>/dev/null || true
  mv "$TMP_BUNDLE" "$HOMEBREW_BUNDLE_FILE"
else
  rm "$TMP_BUNDLE"
  echo "Brewfile already up to date."
fi

echo "Updating Yazi + Neovim..."
(
  ya pkg upgrade >/dev/null 2>&1 &&
    taplo fmt "$DOTFILES"/**/*.toml --config "$DOTFILES"/.taplo.toml &
) &
(
  nvim --headless "+Lazy! sync" -c "qall!" >/dev/null 2>&1
) &
wait

git_commit_push "$DOTFILES" "$DOTFILES/config/yazi/package.toml" "(yazi): update packages"
git_commit_push "$DOTFILES/config/nvim" "$DOTFILES/config/nvim/lazy-lock.json" ": update plugins"

echo "Updating spellfile..."
nvim --headless +'lua require("user.autocmd").sort_spellfile()' +qall! >/dev/null 2>&1
git_commit_push "$DOTFILES/config/nvim" "$DOTFILES/config/nvim/spell" "(spell): update spellfile"

printf "\nDone!\nHappy Hacking, %s 🚀\n" "$(whoami)"
