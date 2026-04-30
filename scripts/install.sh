#!/usr/bin/env bash

set -euo pipefail

# ── Constants ────────────────────────────────────────────────────────────────

DOTFILES="$HOME/dotfiles"
BACKUP_DIR="$HOME/.backup_$(date +"%Y_%m_%d_%T")"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
REPO_URL="https://github.com/snelling-a/dotfiles.git"
INSTEADOF_SET=0

# ── Utility functions ────────────────────────────────────────────────────────

print() {
  printf "\n%s%s%s\n" "$(tput setaf 2)" "$1" "$(tput sgr0)"
}

warn() {
  printf "\n%s%s%s\n" "$(tput setaf 1)" "$1" "$(tput sgr0)"
}

backup() {
  local target="$1"
  # -e: exists, -L: is symlink
  if [[ -e "$target" && ! -L "$target" ]]; then
    mv "$target" "$BACKUP_DIR"
  fi
}

link_file() {
  local file target_dir target
  file="$(realpath "$1")"
  target_dir="${2:-$HOME}"
  target="$target_dir/$(basename "$1")"

  backup "$target"
  # -f: force, -n: don't follow existing symlink, -s: symbolic, -v: verbose
  ln -fnsv "$file" "$target"
}

link_dir() {
  local dir target prefix
  dir="$(realpath "$1")"
  target="${2:-$XDG_CONFIG_HOME}"
  prefix="${3:-}"

  # -F: replace existing directory symlink, -f: force, -n: don't follow existing symlink, -s: symbolic, -v: verbose
  ln -Ffnsv "$dir" "$target/$prefix$(basename "$1")"
}

is_file() {
  # -f: is regular file
  [[ -f "$1" ]]
}

is_dir() {
  # -d: is directory
  [[ -d "$1" ]]
}

is_dotfile_meta() {
  case "$(basename "$1")" in
  . | .. | .git | .gitmodules) return 0 ;;
  esac
  return 1
}

cleanup_insteadof() {
  if [[ "$INSTEADOF_SET" == "1" ]]; then
    git -C "$DOTFILES" config --unset url."https://github.com/".insteadOf || true
    INSTEADOF_SET=0
  fi
}

# ── Step functions ───────────────────────────────────────────────────────────

install_xcode() {
  if xcode-select -p &>/dev/null; then
    print "Xcode Command Line Tools already installed"
    return
  fi

  print "Installing Xcode Command Line Tools..."
  xcode-select --install

  print "Waiting for Xcode Command Line Tools installation..."
  until xcode-select -p &>/dev/null; do
    sleep 5
  done
}

install_homebrew() {
  if command -v brew &>/dev/null; then
    print "Homebrew already installed"
    return
  fi

  print "Installing Homebrew..."
  # -f: fail on HTTP errors, -s: silent, -S: show errors, -L: follow redirects
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # -x: exists and is executable
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  chmod -R go-w "$(brew --prefix)/share"
  print "Homebrew installed"
}

clone_dotfiles() {
  if is_dir "$DOTFILES"; then
    print "Dotfiles already cloned"
    return
  fi

  print "Cloning dotfiles..."
  git clone "$REPO_URL" "$DOTFILES"
}

install_gh() {
  if command -v gh &>/dev/null; then
    print "GitHub CLI already installed"
    return
  fi

  print "Installing GitHub CLI..."
  brew install gh
}

setup_ssh_keys() {
  local ssh_dir="$HOME/.ssh"
  
  if [[ -f "$ssh_dir/id_ed25519" || -f "$ssh_dir/id_rsa" ]]; then
    print "SSH keys already exist"
    
    # Try to add existing keys to ssh-agent
    if [[ -f "$ssh_dir/id_ed25519" ]]; then
      ssh-add "$ssh_dir/id_ed25519" 2>/dev/null || true
    fi
    if [[ -f "$ssh_dir/id_rsa" ]]; then
      ssh-add "$ssh_dir/id_rsa" 2>/dev/null || true
    fi
    
    return
  fi

  print "SSH keys not found in ~/.ssh directory"
  print "Please retrieve your SSH private key from 1Password and place it in ~/.ssh/"
  print "Typically named id_ed25519 or id_rsa"
  
  # Create .ssh directory if it doesn't exist
  mkdir -p "$ssh_dir"
  chmod 700 "$ssh_dir"
  
  print "Once you've placed your SSH key file, press Enter to continue..."
  read -r
  
  # Try to add the key to ssh-agent
  if [[ -f "$ssh_dir/id_ed25519" ]]; then
    ssh-add "$ssh_dir/id_ed25519"
  elif [[ -f "$ssh_dir/id_rsa" ]]; then
    ssh-add "$ssh_dir/id_rsa"
  else
    warn "No SSH key found. You may need to manually set up SSH authentication."
  fi
}

authenticate_github() {
  if gh auth status &>/dev/null; then
    print "Already authenticated with GitHub"
    return
  fi

  print "Authenticating with GitHub..."
  gh auth login --web --git-protocol https
  gh auth setup-git
}

init_submodules() {
  local status
  status=$(git -C "$DOTFILES" submodule status)

  if ! echo "$status" | grep -q '^-'; then
    print "Submodules already initialized"
    return
  fi

  print "Initializing submodules with SSH..."
  git -C "$DOTFILES" submodule update --init --recursive
}

brew_bundle() {
  print "Installing Homebrew packages..."
  brew bundle install --file="$DOTFILES/homebrew/Brewfile"
}

create_symlinks() {
  print "Creating symlinks..."

  for f in "$DOTFILES"/HOME/.* "$DOTFILES"/HOME/local/.*; do
    is_dotfile_meta "$f" && continue
    is_file "$f" && link_file "$f"
  done
}

link_config_directories() {
  print "Linking config directories..."

  for dir in "$DOTFILES"/config/* "$DOTFILES"/config/.local/*; do
    is_dotfile_meta "$dir" && continue
    is_dir "$dir" && link_dir "$dir"
  done
}

link_vimdir() {
  print "Linking vim directory..."
  link_dir "$DOTFILES/vim" "$HOME" '.'
}

setup_vscode() {
  local target="$HOME/Library/Application Support/Code - Insiders/User"

  print "Setting up VS Code..."
  mkdir -p "$target"

  for f in "$DOTFILES/vscode"/*; do
    is_file "$f" && link_file "$f" "$target"
  done
}

generate_zsh_completions() {
  print "Generating zsh completions..."

  local completion_dir="$XDG_DATA_HOME/zsh_completion"

  if ! is_dir "$completion_dir"; then
    mkdir -p "$completion_dir"
  fi

  npm completion >"$completion_dir/_npm"

  print "Completions generated"
}

install_local() {
  if is_file "$DOTFILES/scripts/local/install.sh"; then
    print "Running local install script..."
    bash "$DOTFILES/scripts/local/install.sh"
  fi
}

check_for_backups() {
  # -d: is directory, -n: string is non-empty
  if [[ -d "$BACKUP_DIR" ]] && [[ -n "$(ls -A "$BACKUP_DIR")" ]]; then
    warn "Backup directory is not empty: $BACKUP_DIR"
    ls -la "$BACKUP_DIR"
  elif [[ -d "$BACKUP_DIR" ]]; then
    rm -rf "$BACKUP_DIR"
  fi
}

setup_macos_defaults() {
  while true; do
    read -rp "Setup macOS defaults? [y/n]: " reply
    case "$reply" in
    [Yy])
      bash "$DOTFILES/scripts/macos_defaults.sh"
      break
      ;;
    [Nn])
      break
      ;;
    esac
  done
}

# ── Main ─────────────────────────────────────────────────────────────────────

main() {
  print "Installing dotfiles..."

  mkdir -p "$BACKUP_DIR" "$HOME/work"

  install_xcode
  install_homebrew
  clone_dotfiles
  install_gh
  authenticate_github
  setup_ssh_keys
  init_submodules
  brew_bundle
  create_symlinks
  link_config_directories
  link_vimdir
  setup_vscode
  generate_zsh_completions
  setup_fzf
  install_local
  check_for_backups
  setup_macos_defaults

  print "Installation complete!"
}

main "$@"
