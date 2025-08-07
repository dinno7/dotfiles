[[ -f "$HOME/.config/zsh/functions.zsh" ]] && source "$HOME/.config/zsh/functions.zsh"

# Add the most common personal binary paths located inside the home folder
# (these directories are only added if they exist)
pathprepend "$HOME/bin" "$HOME/sbin" "$HOME/.local/bin" "$HOME/local/bin" "$HOME/.bin"

# TMUX
if [ -z "$TMUX" ]; then
  tmux attach -t TMUX || tmux new -s TMUX
fi

# Add oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/dinno.json)"

# Set oh my zsh
source $ZSH/oh-my-zsh.sh

# Check for the Rust package manager binary install location
# Link: https://doc.rust-lang.org/cargo/index.html
pathappend "$HOME/.cargo/bin"

# Add Go to path
pathappend "$HOME/go/bin/"



# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  # Global
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
  # --------------
  # External
  zsh-bat
  you-should-use
  zsh-interactive-cd
  zsh-autosuggestions
  zsh-syntax-highlighting
  # --------------
  # languages & tools
  git
  nvm
  npm
  node
  golang
  docker
  docker-compose
  # --------------
)

# vim-mode plugin settings
bindkey -M viins 'jk' vi-cmd-mode

# term proxy app
PATH_TERM_PROXY="$HOME/.local/bin/term_proxy"
[ -f $PATH_TERM_PROXY ] && source $PATH_TERM_PROXY

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"


if [ "$(command -v fzf)" ]; then
  # Set up fzf key bindings and fuzzy completion
  eval "$(fzf --zsh)"
fi


