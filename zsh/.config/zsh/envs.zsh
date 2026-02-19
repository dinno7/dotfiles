#! /usr/bin/env bash

export DEFAULT_USER="$(whoami)"
export DINNO_ZSH_LOGO="$HOME/.dinno_logo.txt"

# Locale settings
export LANG="en_US.UTF-8"     # Sets default locale for all categories
export LC_ALL="en_US.UTF-8"   # Overrides all other locale settings
export LC_CTYPE="en_US.UTF-8" # Controls character classification and case conversion

# XDG Base directory specification
export XDG_CACHE_HOME="$HOME/.cache"       # Cache files
export XDG_CONFIG_HOME="$HOME/.config"     # Config files
export XDG_BIN_HOME="$HOME/.local/bin"     # Binary files
export XDG_DATA_HOME="$HOME/.local/share"  # Application data
export XDG_STATE_HOME="$HOME/.local/state" # Logs and state files

export GOPATH="$XDG_DATA_HOME/go"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export DINNO_ZSH_LOGS="$XDG_STATE_HOME/.dinno.logs"
export PATH_TERM_PROXY="$XDG_BIN_HOME/term_proxy"
export TMUX_CONFIG_DIR="$XDG_CONFIG_HOME/tmux"
export OPENCODE_CONFIG_DIR="$XDG_CONFIG_HOME/opencode"
export OPENCODE_CONFIG="$XDG_CONFIG_HOME/opencode/opencode.json"
export NVIM_DATA_DIR="$XDG_DATA_HOME/nvim"
export YAZI_CONFIG_HOME="$XDG_CONFIG_HOME/yazi"

# Password manager
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export PASSWORD_STORE_GENERATED_LENGTH="64"

# NOTE: zsh-vi-mode Config
export ZVM_OPEN_CMD='open'
export ZVM_VI_ESCAPE_BINDKEY='jk'
export ZVM_OPEN_URL_CMD='google-chrome'
export ZVM_SYSTEM_CLIPBOARD_ENABLED=true
export ZVM_INIT_MODE=sourcing

# NOTE: built-in vi-mode(Not use for now)
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export VI_MODE_SET_CURSOR=true
export VI_MODE_CURSOR_NORMAL=2
export VI_MODE_CURSOR_VISUAL=6
export VI_MODE_CURSOR_INSERT=6
export VI_MODE_CURSOR_OPPEND=0
export MODE_INDICATOR="%F{white}+%f"
export INSERT_MODE_INDICATOR="%F{yellow}+%f"

export AI_PROMPT_GIT_COMMIT=$(
  cat <<EOF
You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

1. First line: conventional commit format (type: concise description) (remember to use semantic types like feat, fix, docs, style, refactor, perf, test, chore, etc.)
2. Optional bullet points if more context helps:
   - Keep the second line blank
   - Keep them short and direct
   - Focus on what changed
   - Always be terse
   - Don't overly explain
   - Drop any fluffy or formal language

Return ONLY the commit message - no introduction, no explanation, no quotes around it.

Examples:
feat: add user auth system

- Add JWT tokens for API auth
- Handle token refresh for long sessions

fix: resolve memory leak in worker pool

- Clean up idle connections
- Add timeout for stale workers

Simple change example:
fix: typo in README.md

Very important: Do not respond with any of the examples. Your message must be based off the diff that is about to be provided, with a little bit of styling informed by the recent commits you're about to see.

Based on this format, generate appropriate commit messages. Respond with message only. DO NOT format the message in Markdown code blocks, DO NOT use backticks
EOF
)
