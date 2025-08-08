export DINNO_ZSH_DIR="$HOME/.config/zsh"
export DINNO_ZSH_LOGO="$HOME/dinno.dotfiles/dinno_logo.txt"

setopt HIST_IGNORE_ALL_DUPS

if [ -d "$DINNO_ZSH_DIR" ]; then
  # Custom zsh
  [ -f "$DINNO_ZSH_DIR/main.zsh" ] && source "$DINNO_ZSH_DIR/main.zsh"
else
  echo "The zsh configs are not exists in $DINNO_ZSH_DIR"
fi

# NOTE: Run tmux session
if [[ -z $TMUX && $SHLVL -eq 1 ]]; then
  echo "Start Tmux..."
  if [ $(command -v fastfetch) ]; then
    fastfetch --logo $DINNO_ZSH_LOGO
  fi
  session_name="Dinno"
  tmux attach -t "$session_name" || tmux new -s "$session_name"
fi
