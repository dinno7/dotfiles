# NOTE: Load functions to has access to sourcefile function
[ -s "$DINNO_ZSH_DIR/functions.zsh" ] && source "$DINNO_ZSH_DIR/functions.zsh"

# NOTE: load main parts
sourcefile "$DINNO_ZSH_DIR/env.zsh"
sourcefile "$DINNO_SECRET_PATH"
sourcefile "$DINNO_ZSH_DIR/theme.zsh"
sourcefile "$DINNO_ZSH_DIR/aliases.zsh"
sourcefile "$DINNO_ZSH_DIR/paths.zsh"

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
sourcefile $ZSH/oh-my-zsh.sh

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
sourcefile "$PATH_TERM_PROXY"


# NOTE: Hook direnv (https://direnv.net/)
if [ "$(command -v direnv)" ];then
  eval "$(direnv hook zsh)"
fi

# NOTE: NVM
# This loads nvm
# This loads nvm bash_completion
sourcefile "$NVM_DIR/nvm.sh" "$NVM_DIR/bash_completion"

# NOTE: Automatically run nvm use when entering a directory if it contains a .nvm file.
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
