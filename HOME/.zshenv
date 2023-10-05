export DO_NOT_TRACK=1

export PATH=~/.local/bin:$PATH

export DOTFILES="$HOME/dotfiles"
export VIMDIR="$DOTFILES/vim"
export WORK="$HOME/work"
export NOTES="$HOME/notes"
export AWKPATH="$DOTFILES/awk/"

export VISUAL=nvim
export EDITOR="$VISUAL"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_STATE_HOME="${HOME}/.local/share/state"

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

[[ -f "$HOME/.zshenv_local" ]] && source "$HOME/.zshenv_local"
