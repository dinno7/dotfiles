# NOTE: Apply custom envs
[[ -f "$DINNO_ZSH_DIR/env.zsh" ]] && source "$DINNO_ZSH_DIR/env.zsh"
# NOTE: Apply custom functions
[[ -f "$DINNO_ZSH_DIR/functions.zsh" ]] && source "$DINNO_ZSH_DIR/functions.zsh"


# NOTE: Apply custom zsh theme
[[ -f "$DINNO_ZSH_DIR/theme.zsh" ]] && source "$DINNO_ZSH_DIR/theme.zsh"

# NOTE: Add the most common personal binary paths located inside the home folder
# (these directories are only added if they exist)
pathprepend "$HOME/bin" "$HOME/sbin" "$HOME/.local/bin" "$HOME/local/bin" "$HOME/.bin"

# NOTE: Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  # NOTE: Global
  z
  ufw
  fzf
  sudo
  vi-mode
  extract
  copyfile
  jsontools
  dirhistory
  web-search
  # zsh-interactive-cd
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

# NOTE: vim-mode plugin settings
bindkey -M viins 'jk' vi-cmd-mode

# NOTE: Apply aliases
[[ -f "$DINNO_ZSH_DIR/aliases.zsh" ]] && source "$DINNO_ZSH_DIR/aliases.zsh"

# NOTE: term proxy app
PATH_TERM_PROXY="$HOME/.local/bin/term_proxy"
[ -f $PATH_TERM_PROXY ] && source $PATH_TERM_PROXY

# NOTE: Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"


if [ "$(command -v fzf)" ]; then
  # NOTE: Set up fzf key bindings and fuzzy completion
  eval "$(fzf --zsh)"
fi

# NOTE: Hook direnv (https://direnv.net/)
if [ "$(command -v direnv)" ];then
  eval "$(direnv hook zsh)"
fi

# NOTE: Add additional paths
[[ -f "$DINNO_ZSH_DIR/paths.zsh" ]] && source "$DINNO_ZSH_DIR/paths.zsh"

