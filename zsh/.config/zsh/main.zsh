#! /usr/bin/env bash

# NOTE: Load pre
source "$DINNO_ZSH_DIR/pre_load.zsh"

# NOTE: Plugins
plugins=(
  # NOTE: Global
  ssh-agent
  urltools
  copyfile
  copypath
  # NOTE: External
  fzf-tab
  zsh-vi-mode
  zsh-you-should-use
  zsh-autosuggestions
  fast-syntax-highlighting
  # NOTE: languages & tools
  git
  npm
  rust
  golang
  docker
  docker-compose
)

# NOTE: Plugin settings
# NOTE: Make ssh-agent lazy load
zstyle :omz:plugins:ssh-agent lazy yes
zstyle :omz:plugins:ssh-agent quiet yes

# NOTE: Enable add zsh hook
autoload -U add-zsh-hook

# NOTE: Autosuggestions accept
bindkey '^n' autosuggest-accept

# NOTE: Setup oh my zsh
sourcefiles "$ZSH/oh-my-zsh.sh"

# NOTE: after load hook
sourcefiles "$DINNO_ZSH_DIR/after_load.zsh"
