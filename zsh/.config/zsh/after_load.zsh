#! /usr/bin/env bash

if [ -n "$TMUX" ]; then
  # NOTE: One tmux call -> "<sessions> <windows in current session>"
  tmux_counts=("${(@s: :)$(tmux display-message -p '#{server_sessions} #{session_windows}' 2>/dev/null)}")
  if [[ "${tmux_counts[1]}" = 1 && "${tmux_counts[2]}" = 1 ]]; then
    if cmd_exists fastfetch; then
      fastfetch --logo "$DINNO_ZSH_LOGO"
    elif cmd_exists neofetch; then
      neofetch --source "$DINNO_ZSH_LOGO"
    else
      command cat "$DINNO_ZSH_LOGO"
    fi
  fi
  unset tmux_counts
fi

# NOTE: load main parts
# envs load again to do not overwritten with other apps
sourcefiles "$DINNO_ZSH_DIR/dynamic_envs.zsh" "$DINNO_ZSH_DIR/functions.zsh" "$DINNO_ZSH_DIR/aliases.zsh" "$DINNO_ZSH_DIR/setup_tools.zsh"
