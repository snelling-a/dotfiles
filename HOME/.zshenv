export PATH=~/.local/bin:$PATH

export DOTFILES="$HOME/dotfiles"
export VIMDIR="$DOTFILES/vim"
export WORK="$HOME/work"
export NOTES="$HOME/notes"
export AWKPATH="$DOTFILES/awk/"

export VISUAL=nvim
export EDITOR="$VISUAL"
# this needs to be set in order for packer to install luarocks dependencies
export MACOSX_DEPLOYMENT_TARGET=10.15

export XDG_CONFIG_HOME="$HOME/.config"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

[[ -f "$HOME/.zshenv_local" ]] && source "$HOME/.zshenv_local"
