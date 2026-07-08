#! /usr/bin/env bash

if [ -n "$TMUX" ]; then
  tmux_sessions_count="$(tmux list-sessions | wc -l)"
  tmux_windows_count="$(tmux list-windows | wc -l)"
  if [[ "$tmux_sessions_count" = 1 && "$tmux_windows_count" = 1 ]]; then
    if command -v fastfetch >/dev/null 2>&1; then
      fastfetch --logo "$DINNO_ZSH_LOGO"
    elif command -v neofetch >/dev/null 2>&1; then
      neofetch --source "$DINNO_ZSH_LOGO"
    else
      cat -p "$DINNO_ZSH_LOGO"
    fi
  fi
fi

# NOTE: Automatically run nvm use when entering a directory if it contains a .nvm file.
if cmd_exists nvm; then
  autoload -U add-zsh-hook
  load-nvmrc() {
    if [[ -f .nvmrc && -r .nvmrc ]]; then
      nvm use
    fi
  }
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
fi

# NOTE: load main parts
# envs load again to do not overwritten with other apps
sourcefiles "$DINNO_ZSH_DIR/dynamic_envs.zsh" "$DINNO_ZSH_DIR/aliases.zsh" "$DINNO_ZSH_DIR/functions.zsh" "$DINNO_ZSH_DIR/setup_tools.zsh"

# NOTE: Remove duplicated path in $PATH
declare -A saw
final_path=""
IFS=':' read -r -A parts <<<"$PATH"
for s in "${parts[@]}"; do
  if [ -z "${saw["$s"]}" ]; then
    final_path+="$s:"
    saw["$s"]="true"
  fi
done
final_path="${final_path%:}" # Remove final : character
export PATH="$final_path"
