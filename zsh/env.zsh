# Secrets
[ -f "$HOME/.env" ] && source "$HOME/.env"

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"


export TMUX_CONFIG_DIR="$HOME/.config/tmux"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# XDG Base directory specification
export XDG_CONFIG_HOME="$HOME/.config"         # Config files
export XDG_CACHE_HOME="$HOME/.cache"           # Cache files
export XDG_DATA_HOME="$HOME/.local/share"      # Application data
export XDG_STATE_HOME="$HOME/.local/state"     # Logs and state files

# Themes (onedark or nord)
export TMUX_THEME="nord"
export NVIM_THEME="nord"
export STARSHIP_THEME="nord"
export WEZTERM_THEME="nord"

# Locale settings
export LANG="en_US.UTF-8" # Sets default locale for all categories
export LC_ALL="en_US.UTF-8" # Overrides all other locale settings
export LC_CTYPE="en_US.UTF-8" # Controls character classification and case conversion


# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Use Neovim as default editor
export VISUAL=nvim visudo
export SUDO_EDITOR=nvim
export FCEDIT=nvim

if [[ -x "$(command -v bat)" ]]; then
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
	export PAGER=bat
  # Fix bat formatting problems
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
