export PATH=~/.local/bin:$PATH

export DOTFILES=$HOME/dotfiles
export VIMDIR=$DOTFILES/vim
export WORK=$HOME/work

export VISUAL=nvim
export EDITOR="$VISUAL"

export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

[[ -f .zshenv_local ]] && source .zshenv_local
