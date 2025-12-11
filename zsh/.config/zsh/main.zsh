# NOTE: Load pre
source "$DINNO_ZSH_DIR/pre_load.zsh"

# NOTE: Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# NOTE: Plugins
plugins=(
  # NOTE: Global
  fzf
  sudo
  ssh
  ssh-agent
  rsync
  systemd
  vi-mode
  extract
  urltools
  copyfile
  dirhistory
  # NOTE: External
  you-should-use
  zsh-autosuggestions
  zsh-syntax-highlighting
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

# NOTE: Enable command auto-correction.
ENABLE_CORRECTION="true"

# NOTE: vim-mode plugin settings
bindkey -M viins 'jk' vi-cmd-mode

# NOTE: Set Zoxide
if cmd_exists zoxide;then
  eval "$(zoxide init zsh)"
fi

# NOTE: Set up fzf key bindings and fuzzy completion
if cmd_exists fzf; then
  eval "$(fzf --zsh)"
fi

# NOTE: Hook direnv (https://direnv.net/)
if cmd_exists direnv;then
  eval "$(direnv hook zsh)"
fi

# NOTE: NVM
sourcefiles "$NVM_DIR/nvm.sh" "$NVM_DIR/bash_completion"

# NOTE: before load hook
sourcefiles "$DINNO_ZSH_DIR/after_load.zsh"
