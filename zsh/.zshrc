export DINNO_ZSH_DIR="$HOME/.config/zsh"

setopt HIST_IGNORE_ALL_DUPS

if [ -d "$DINNO_ZSH_DIR" ]; then
  [ -f "$DINNO_ZSH_DIR/main.zsh" ] && source "$DINNO_ZSH_DIR/main.zsh"
else
  echo "The zsh configs are not exists in $DINNO_ZSH_DIR"
fi

