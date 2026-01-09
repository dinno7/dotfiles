# NOTE: Load pre
source "$DINNO_ZSH_DIR/pre_load.zsh"

# NOTE: Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# NOTE: Plugins
plugins=(
  # NOTE: Global
  sudo
  ssh
  ssh-agent
  rsync
  systemd
  urltools
  copyfile
  dirhistory
  # NOTE: External
  fzf-tab
  zsh-vi-mode
  you-should-use
  zsh-autosuggestions
  fast-syntax-highlighting
  # NOTE: languages & tools
  git
  nvm
  npm
  node
  golang
  docker
  docker-compose
)

# NOTE: Set oh my zsh
source $ZSH/oh-my-zsh.sh

# NOTE: Set up fzf key bindings and fuzzy completion
if cmd_exists fzf; then
  eval "$(fzf --zsh)"
fi

# NOTE: Set Zoxide
if cmd_exists zoxide;then
  eval "$(zoxide init zsh)"
fi

# NOTE: Hook direnv (https://direnv.net/)
if cmd_exists direnv;then
  eval "$(direnv hook zsh)"
fi

# NOTE: Autosuggestions accept
bindkey '^n' autosuggest-accept

# NOTE: vim-mode plugin settings
# bindkey -M viins 'jk' vi-cmd-mode

# NOTE: after load hook
sourcefiles "$DINNO_ZSH_DIR/after_load.zsh"
