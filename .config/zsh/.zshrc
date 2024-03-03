# Detected operating system
load_zsh_plugins() {
    case "$(uname)" in
        "Darwin")
            PLUGIN_PATH=(
                "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
                "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
                "/opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
            )
            ;;
        "Linux")
            if [ -f /etc/arch-release ]; then
                PLUGIN_PATH=(
                    "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
                    "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
                    "/usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
                )
            elif [ -f /etc/debian_version ]; then
                PLUGIN_PATH="$HOME/.zsh/debian_plugins"
            elif [ -f /etc/redhat-release ]; then
                PLUGIN_PATH=(
                    "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
                    "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
                )
            fi
            ;;
        "FreeBSD")
            PLUGIN_PATH="$HOME/.zsh/freebsd_plugins"
            ;;
        *)
            echo "Unsupported operating system."
            return 1
            ;;
    esac

    for plugin_file in "${PLUGIN_PATH[@]}"; do
        if [ -f "$plugin_file" ]; then
            source "$plugin_file"
        fi
    done
}

load_zsh_plugins

# Common configs
export EDITOR=nvim
export VISUAL=nvim

# Tab autocompletion
autoload -U compinit
#zstyle '*:compinit' arguments -D -i -u -C -w
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

# GIT status
autoload -Uz vcs_info
precmd() { vcs_info }
setopt prompt_subst
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
zstyle ':vcs_info:git:*' formats       '{%b%u%c}'
zstyle ':vcs_info:git:*' actionformats '{%b|%a%u%c}'

# Prompt
PROMPT='%B%F{198}[%f%b%B%F{198}%m%f%b%B%F{198}]%f%b %F{48}(%f%F{48}%~%f%F{48})%f %F{220}%#%f '
RPROMPT='%B%F{141}${vcs_info_msg_0_}%f%b %F{214}%T%f %F{202}|%f %F{156}%W%f'

# Set keybinding to emacs instead of vi
bindkey -e

# History
setopt CORRECT
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt NOTIFY
setopt NOHUP
setopt MAILWARN
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
#unsetopt EXTENDED_HISTORY // Remove the timestamps from history file.

HISTFILE=$ZDOTDIR/.history
HISTSIZE=500000
SAVEHIST=500000

# Plugin customization
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets pattern cursor)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#fF7F50,bold,underline"

# Custom autocompletion path
fpath=($HOME/.local/share/zsh/completions $fpath)

# Alliases
source ~/.config/zsh/.zsh_aliases
