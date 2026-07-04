#! /usr/bin/env bash

setopt globdots

# NOTE: Load functions to has access to sourcefiles function
[ -s "$DINNO_ZSH_DIR/functions.zsh" ] && source "$DINNO_ZSH_DIR/functions.zsh"

# NOTE: load static envs
sourcefiles "$DINNO_ZSH_DIR/envs.zsh" "$DINNO_ZSH_DIR/paths.zsh"

# NOTE: Run tmux session
if [ -z "$TMUX" ] && [ -n "$PS1" ]; then
  echo "Starting Tmux..."
  session_name="$DEFAULT_USER"
  tmux new -A -s "$session_name"
  return 0
fi
