if command -v nvim >/dev/null 2>&1;then
  export EDITOR="nvim"
  export DINNO_NVIM_DIR="$XDG_CONFIG_HOME/nvim"
elif command -v vim >/dev/null 2>&1;then
  export EDITOR='vim'
fi

if command -v batcat >/dev/null 2>&1 || command -v bat >/dev/null 2>&1;then
  if command -v batcat >/dev/null 2>&1; then
    export PAGER="batcat"
  elif command -v bat >/dev/null 2>&1; then
    export PAGER="bat"
  fi
  export MANPAGER="sh -c 'col -bx | $PAGER -l man -p'"
  export MANROFFOPT="-c"
  if command -v less >/dev/null 2>&1;then
    export BAT_PAGER="less -RKX"
    export BAT_PAGING="always"
  fi
fi


if command -v fzf >/dev/null 2>&1;then
  export FZF_BASE="$(dirname "$(which fzf)")"
  export FZF_DEFAULT_OPTS="--tmux 80% --border=bold --border=rounded --layout=reverse --preview 'bat --color=always {}' --no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b"
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"
fi

export BW_PASSWORD="$(pass main/bw)"
export GEMINI_API_KEY="$(pass apikey/gemini)"
