#!/usr/bin/env bash
# vim:filetype=sh

export DO_NOT_TRACK=1

export PATH="${HOME}/.local/bin:$PATH"

export DOTFILES="$HOME/dotfiles"
export VIMDIR="$DOTFILES/vim"
export WORK="$HOME/work"
export NOTES="$HOME/notes"

export LANG=en_US.UTF-8
export MANPAGER='nvim +Man!'
export DELTA_FEATURES='+side-by-side'

export VISUAL=nvim
export EDITOR="$VISUAL"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_STATE_HOME="${HOME}/.local/share/state"

export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/ripgrep/.ripgreprc"
export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/starship/starship.toml"

export _ZO_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zoxide"
export FNM_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fnm"

[[ -f "$HOME/.zshenv_local" ]] && source "$HOME/.zshenv_local"

[[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/op/plugins.sh" ]] && source "${XDG_CONFIG_HOME:-$HOME/.config}/op/plugins.sh"
