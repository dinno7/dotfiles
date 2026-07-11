#! /usr/bin/env bash

setopt globdots

# NOTE: Load pre functions to get access to some initial functions
[ -s "$DINNO_ZSH_DIR/pre_functions.zsh" ] && source "$DINNO_ZSH_DIR/pre_functions.zsh"

# NOTE: load static envs
sourcefiles "$DINNO_ZSH_DIR/paths.zsh" "$DINNO_ZSH_DIR/envs.zsh"

# NOTE: Run tmux session
if [ -z "$TMUX" ] && [ -n "$PS1" ]; then
  echo "Starting Tmux..."
  session_name="$(capitalize_word "$DEFAULT_USER")"
  tmux new -A -s "$session_name"
  return 0
fi
