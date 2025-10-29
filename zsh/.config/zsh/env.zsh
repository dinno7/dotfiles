export DINNO_SECRET_PATH="$HOME/.env"
export DINNO_NVIM_DIR="$HOME/.config/nvim"
export DINNO_ZSH_LOGO="$HOME/.dinno_logo.txt"

export TMUX_CONFIG_DIR="$HOME/.config/tmux"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# XDG Base directory specification
export XDG_CONFIG_HOME="$HOME/.config"         # Config files
export XDG_CACHE_HOME="$HOME/.cache"           # Cache files
export XDG_DATA_HOME="$HOME/.local/share"      # Application data
export XDG_STATE_HOME="$HOME/.local/state"     # Logs and state files

# Locale settings
export LANG="en_US.UTF-8" # Sets default locale for all categories
export LC_ALL="en_US.UTF-8" # Overrides all other locale settings
export LC_CTYPE="en_US.UTF-8" # Controls character classification and case conversion

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Use Neovim as default editor
export VISUAL=nvim visudo
export SUDO_EDITOR=nvim
export FCEDIT=nvim

if command -v batcat >/dev/null 2>&1; then
  export PAGER=batcat
  export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
  export MANROFFOPT="-c"
elif command -v bat >/dev/null 2>&1; then
  export PAGER=bat
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"
fi



export FZF_DEFAULT_OPTS="--tmux 80% --border=bold --border=rounded --layout=reverse --preview 'bat --color=always {}' --no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

# Hide computer name in terminal
export DEFAULT_USER="$(whoami)"

# Config vim in zsh
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export VI_MODE_SET_CURSOR=true
export VI_MODE_CURSOR_NORMAL=2
export VI_MODE_CURSOR_VISUAL=6
export VI_MODE_CURSOR_INSERT=6
export VI_MODE_CURSOR_OPPEND=0
export MODE_INDICATOR="%F{white}+%f"
export INSERT_MODE_INDICATOR="%F{yellow}+%f"

export GOPATH="$HOME/go"

export NVM_DIR="$HOME/.nvm"
export PNPM_HOME="$HOME/.local/share/pnpm"

export DINNO_ZSH_LOGS="$HOME/.dinno.logs"

export PATH_TERM_PROXY="$HOME/.local/bin/term_proxy"

export AI_PROMPT_GIT_COMMIT=$(cat << EOF
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
