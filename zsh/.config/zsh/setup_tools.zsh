#! /usr/bin/env bash

# NOTE: Set starship
if cmd_exists starship; then
  eval "$(starship init zsh)"
fi

# NOTE: Set Zoxide
if cmd_exists zoxide; then
  eval "$(zoxide init zsh)"
fi

# NOTE: Set up fzf key bindings and fuzzy completion
if cmd_exists fzf; then
  eval "$(fzf --zsh)"
fi

# NOTE: Hook direnv (https://direnv.net/)
if cmd_exists direnv; then
  eval "$(direnv hook zsh)"
fi

# NOTE: Set up just completion
if cmd_exists just; then
  eval "$(just --completions zsh)"
fi
