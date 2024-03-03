export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# HOMEBREW
export PATH="/opt/homebrew/bin:$PATH"

# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"

# ANSIBLE
export ANSIBLE_HOME="$XDG_DATA_HOME"/ansible

# Remove lesshist file
export LESSHISTFILE=-
