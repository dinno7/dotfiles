if cmd_exists nvim || cmd_exists vim;then
  if cmd_exists nvim;then
    export EDITOR="nvim"
    export DINNO_NVIM_DIR="$XDG_CONFIG_HOME/nvim"
  elif cmd_exists vim;then
    export EDITOR='vim'
  fi
  export VISUAL="$EDITOR visudo"
  export SUDO_EDITOR="$EDITOR"
  export FCEDIT="$EDITOR"
fi


if cmd_exists batcat || cmd_exists bat;then
  if cmd_exists batcat; then
    export PAGER="batcat"
  elif cmd_exists bat; then
    export PAGER="bat"
  fi
  export MANPAGER="sh -c 'col -bx | $PAGER -l man -p'"
  export MANROFFOPT="-c"
  if cmd_exists less;then
    export BAT_PAGER="less -RKX"
    export BAT_PAGING="always"
  fi
fi


if cmd_exists fzf;then
  export FZF_BASE="$(dirname "$(which fzf)")"
  if cmd_exists fd;then
    export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
  fi
  export FZF_DEFAULT_OPTS="--tmux 75% --border=bold --border=rounded --layout=reverse --preview 'bat {}' --no-height"
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

  # https://github.com/tinted-theming/tinted-fzf/tree/main/bash
  local color00='#1a1b26'
  local color01='#16161e'
  local color02='#2f3549'
  local color03='#444b6a'
  local color04='#787c99'
  local color05='#a9b1d6'
  local color06='#cbccd1'
  local color07='#d5d6db'
  local color08='#c0caf5'
  local color09='#a9b1d6'
  local color0A='#0db9d7'
  local color0B='#9ece6a'
  local color0C='#b4f9f8'
  local color0D='#2ac3de'
  local color0E='#bb9af7'
  local color0F='#f7768e'
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS
  --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"
fi
