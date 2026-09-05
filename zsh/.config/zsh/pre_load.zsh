#! /usr/bin/env bash

setopt globdots

# NOTE: Load pre functions to get access to some initial functions
[ -s "$DINNO_ZSH_DIR/pre_functions.zsh" ] && source "$DINNO_ZSH_DIR/pre_functions.zsh"

# NOTE: load static envs
sourcefiles "$DINNO_ZSH_DIR/paths.zsh" "$DINNO_ZSH_DIR/envs.zsh"

# NOTE: Run tmux session
if [ "$WITHOUT_TMUX" != "true" ] && [ -z "$TMUX" ] && [ -n "$PS1" ]; then
  session_name="$(capitalize_word "$DEFAULT_USER")"
  if tmux has -t "$session_name"; then
    session_name="$session_name-$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 3)"
  fi
  echo "Starting \"$session_name\" session in Tmux..."
  tmux new -A -s "$session_name"
  return 0
fi
