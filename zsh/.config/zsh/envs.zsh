#! /usr/bin/env bash

export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"
export DEFAULT_USER="${USER:-$(whoami)}"
export DINNO_ZSH_LOGO="$HOME/.dinno_logo.txt"

# Locale settings
export LANG="en_US.UTF-8"     # Sets default locale for all categories
export LC_ALL="en_US.UTF-8"   # Overrides all other locale settings
export LC_CTYPE="en_US.UTF-8" # Controls character classification and case conversion

# XDG Base directory specification
export XDG_CACHE_HOME="$HOME/.cache"       # Cache files
export XDG_CONFIG_HOME="$HOME/.config"     # Config files
export XDG_BIN_HOME="$HOME/.local/bin"     # Binary files
export XDG_DATA_HOME="$HOME/.local/share"  # Application data
export XDG_STATE_HOME="$HOME/.local/state" # Logs and state files

export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

export GOPATH="$XDG_DATA_HOME/go"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export FNM_DIR="$XDG_DATA_HOME/fnm"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export DINNO_ZSH_LOGS="$XDG_STATE_HOME/.dinno.logs"
export TMUX_CONFIG_DIR="$XDG_CONFIG_HOME/tmux"
export OPENCODE_CONFIG_DIR="$XDG_CONFIG_HOME/opencode"
export OPENCODE_CONFIG="$XDG_CONFIG_HOME/opencode/opencode.json"
export NVIM_DATA_DIR="$XDG_DATA_HOME/nvim"
export YAZI_CONFIG_HOME="$XDG_CONFIG_HOME/yazi"
export JAVA_HOME=/opt/android-studio/jbr
export ANDROID_HOME="$HOME/Android/Sdk"
# INFO: Pick the newest installed NDK (zsh glob: dirs only, sorted by name, last one)
_ndk_latest=("$ANDROID_HOME"/ndk/*(N/on[-1]))
[ -n "$_ndk_latest" ] && export NDK_HOME="$_ndk_latest"
unset _ndk_latest

# Password manager
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export PASSWORD_STORE_GENERATED_LENGTH="64"

# NOTE: zsh-vi-mode Config
export ZVM_OPEN_CMD='open'
export ZVM_VI_ESCAPE_BINDKEY='jk'
export ZVM_OPEN_URL_CMD='google-chrome'
export ZVM_SYSTEM_CLIPBOARD_ENABLED=true
export ZVM_INIT_MODE=sourcing

# NOTE: built-in vi-mode(Not use for now)
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export VI_MODE_SET_CURSOR=true
export VI_MODE_CURSOR_NORMAL=2
export VI_MODE_CURSOR_VISUAL=6
export VI_MODE_CURSOR_INSERT=6
export VI_MODE_CURSOR_OPPEND=0
export MODE_INDICATOR="%F{white}+%f"
export INSERT_MODE_INDICATOR="%F{yellow}+%f"

export OMZ_EXTERNAL_PLUGINS=(
  "Aloxaf/fzf-tab"
  "jeffreytse/zsh-vi-mode"
  "zsh-users/zsh-autosuggestions"
  "MichaelAquilina/zsh-you-should-use"
  "zdharma-continuum/fast-syntax-highlighting"
)


