# zsh Options
export DINNO_ZSH_DIR=$HOME/.config/zsh
setopt HIST_IGNORE_ALL_DUPS

if [ -d "$DINNO_ZSH_DIR" ]; then

  if command -v fastfetch &>/dev/null; then
    fastfetch --logo ./dinno_logo.txt
  fi

  PATH_ZSH_CUSTOM="$HOME/.config/zsh/main.zsh"
  PATH_ZSH_ALIASES="$HOME/.config/zsh/aliases.zsh"

  # Custom zsh
  [ -f $PATH_ZSH_CUSTOM ] && source $PATH_ZSH_CUSTOM

  # Aliases
  [ -f $PATH_ZSH_ALIASES ] && source $PATH_ZSH_ALIASES
else
  echo "The zsh configs are not exists in $DINNO_ZSH_DIR"
fi
