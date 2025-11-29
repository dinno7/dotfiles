# NOTE: Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# NOTE: Plugins
plugins=(
  # NOTE: Global
  ufw
  fzf
  sudo
  vi-mode
  extract
  copyfile
  jsontools
  dirhistory
  web-search
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

# NOTE: Load functions to has access to sourcefiles function
[ -s "$DINNO_ZSH_DIR/functions.zsh" ] && source "$DINNO_ZSH_DIR/functions.zsh"

# NOTE: load main parts
sourcefiles "$DINNO_ZSH_DIR/env.zsh"
sourcefiles "$DINNO_ZSH_DIR/aliases.zsh"
sourcefiles "$DINNO_ZSH_DIR/paths.zsh"
sourcefiles "$DINNO_ZSH_DIR/theme.zsh"


# NOTE: Enable command auto-correction.
ENABLE_CORRECTION="true"

# NOTE: vim-mode plugin settings
bindkey -M viins 'jk' vi-cmd-mode

# NOTE: Set Zoxide
if [[ -x "$(command -v zoxide)" ]];then
  eval "$(zoxide init zsh)"
fi

# NOTE: Set up fzf key bindings and fuzzy completion
if [ "$(command -v fzf)" ]; then
  eval "$(fzf --zsh)"
fi

# NOTE: term proxy app
sourcefiles "$PATH_TERM_PROXY"

# NOTE: Hook direnv (https://direnv.net/)
if [ "$(command -v direnv)" ];then
  eval "$(direnv hook zsh)"
fi

# NOTE: NVM
# This loads nvm
# This loads nvm bash_completion
sourcefiles "$NVM_DIR/nvm.sh" "$NVM_DIR/bash_completion"

# NOTE: before load hook
sourcefiles "$DINNO_ZSH_DIR/after_load.zsh"
