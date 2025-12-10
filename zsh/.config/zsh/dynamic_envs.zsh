
if command -v nvim >/dev/null 2>&1;then
  export EDITOR="nvim"
  export VISUAL="nvim visudo"
  export SUDO_EDITOR="nvim"
  export FCEDIT="nvim"
  export DINNO_NVIM_DIR="$XDG_CONFIG_HOME/nvim"
elif command -v vim >/dev/null 2>&1;then
  export EDITOR='vim'
  export VISUAL="vim visudo"
  export SUDO_EDITOR="vim"
  export FCEDIT="vim"
fi

if command -v tmux >/dev/null 2>&1;then
  export TMUX_CONFIG_DIR="$XDG_CONFIG_HOME/tmux"
fi

if command -v batcat >/dev/null 2>&1; then
  export PAGER=batcat
  export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
  export MANROFFOPT="-c"
elif command -v bat >/dev/null 2>&1; then
  export PAGER=bat
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"
fi

if command -v fzf >/dev/null 2>&1;then
  export FZF_BASE="$(dirname "$(which fzf)")"
  export FZF_DEFAULT_OPTS="--tmux 80% --border=bold --border=rounded --layout=reverse --preview 'bat --color=always {}' --no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b"
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"
fi

