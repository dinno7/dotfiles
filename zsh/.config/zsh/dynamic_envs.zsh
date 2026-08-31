#! /usr/bin/env bash

if cmd_exists nvim || cmd_exists vim; then
  if cmd_exists nvim; then
    export EDITOR="nvim"
    export DINNO_NVIM_DIR="$XDG_CONFIG_HOME/nvim"
  elif cmd_exists vim; then
    export EDITOR='vim'
  fi
  export FCEDIT="$EDITOR"
  export SUDO_EDITOR="$EDITOR"
  export VISUAL="$EDITOR"
  export GIT_EDITOR="$EDITOR"
  export SUDO_EDITOR="$EDITOR --clean"
  export ZVM_VI_EDITOR="$EDITOR"
  export ZVM_OPEN_FILE_CMD="$EDITOR"
fi

if cmd_exists batcat || cmd_exists bat; then
  if cmd_exists batcat; then
    export PAGER="batcat"
  elif cmd_exists bat; then
    export PAGER="bat"
  fi
  export MANPAGER="sh -c 'col -bx | $PAGER -l man -p'"
  export MANROFFOPT="-c"
  if cmd_exists less; then
    export BAT_PAGER="less -RKX"
    export BAT_PAGING="always"
  fi
fi

if cmd_exists fzf; then
  export FZF_BASE="$(dirname "$(which fzf)")"
  if cmd_exists fd; then
    export FZF_DEFAULT_COMMAND="fd --type=f --hidden --max-depth 10 --strip-cwd-prefix --exclude .git"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
  else
    export FZF_DEFAULT_COMMAND="find -type f . -maxdepth 10 -not -path '*/\.git/*' -not -name '.git' -print0 | xargs -0 sed 's|^\./||'"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="find . -maxdepth 10 -type d -not -path '*/\.git/*' -not -name '.git'"
  fi

  export FZF_DEFAULT_OPTS="--walker-skip .git,node_modules,target"
  #   --tmux center,75%
  #   --layout=reverse

  # INFO: Preview configurations
  if cmd_exists bat; then
    FZF_FILE_PREVIEW='bat --style=full --color=always --line-range :100 {}'
  else
    FZF_FILE_PREVIEW='cat --number {}'
  fi
  if cmd_exists tree; then
    FZF_DIR_PREVIEW='tree -C {} | head -100'
  else
    FZF_DIR_PREVIEW='echo "Install \`tree\` to see preview of directories"'
  fi
  FZF_PREVIEW_COMMAND="if [ -d {} ]; then $FZF_DIR_PREVIEW; else $FZF_FILE_PREVIEW; fi"
  FZF_PREVIEW_OPTS="
    --bind 'ctrl-/:change-preview-window(up|right|hidden|)'
    --bind 'ctrl-\:change-preview-window(hidden|)'
    --preview '$FZF_PREVIEW_COMMAND'
    --preview-window 'bottom:80%'
    --preview-border 'rounded'
    --preview-label 'Press CTRL-\ or CTRL-/ to toggle preview'
  "

  # INFO: Binds
  FZF_CTRL_R_BINDS='
    --color "header:italic"
    --header "Press CTRL-Y to copy command into clipboard"
    --bind "ctrl-y:execute-silent(echo -n {2..} | xclip -sel clip)+abort"
  '
  FZF_CTRL_T_BINDS='
    --color "header:italic"
    --header "CTRL-Y -> Copy file(s), CTRL-O -> Open file"
    --bind "space:toggle"
    --bind "ctrl-space:toggle"
    --bind "ctrl-o:execute($EDITOR {})"
    --bind "ctrl-u:preview-page-up,ctrl-d:preview-page-down"
    --bind "ctrl-alt-k:preview-up,ctrl-alt-j:preview-down"
    --bind "ctrl-y:execute(v=\"\"; for f in {+};do v+=\"$(echo \"\nFILE: $f\n-----\n$(cat $f)\n-----\n\")\" done; echo \"$v\" | sed \"s/^[[:space:]]*//;s/[[:space:]]*$//\" | xclip -sel clip)"
  '
  FZF_ALT_C_BINDS='
    --color "header:italic"
    --header "CTRL-Y -> Copy path, CTRL-O -> Open direcotry(UI), CTRL-E -> Open direcotry(EDITOR)"
    --bind "ctrl-o:execute(xdg-open {})"
    --bind "ctrl-e:execute($EDITOR {})"
    --bind "ctrl-y:execute(realpath {} | xclip -sel clip)"
    --bind "ctrl-u:preview-page-up,ctrl-d:preview-page-down"
    --bind "ctrl-alt-k:preview-up,ctrl-alt-j:preview-down"
  '

  export FZF_CTRL_R_OPTS="$FZF_CTRL_R_BINDS"
  export FZF_CTRL_T_OPTS="
    $FZF_CTRL_T_BINDS
    $FZF_PREVIEW_OPTS
  "
  export FZF_ALT_C_OPTS="
    $FZF_ALT_C_BINDS
    $FZF_PREVIEW_OPTS
  "

  # https://github.com/tinted-theming/tinted-fzf/tree/main/bash
  # color00='#08080b'
  color00='#000000'
  color01='#16161e'
  #color02='#2f3549'
  #color03='#444b6a'
  color04='#787c99'
  #color05='#a9b1d6'
  color06='#cbccd1'
  #color07='#d5d6db'
  #color08='#c0caf5'
  #color09='#a9b1d6'
  color0A='#0db9d7'
  #color0B='#9ece6a'
  color0C='#b4f9f8'
  color0D='#2ac3de'
  #color0E='#bb9af7'
  #color0F='#f7768e'
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS
  --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

  # NOTE: fzf-tab plugin
  # --------------------------
  # disable sort when completing `git checkout`
  # zstyle ':completion:*:git-checkout:*' sort false
  zstyle ':completion:*' sort false
  # set descriptions format to enable group support
  # NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
  zstyle ':completion:*:descriptions' format '[%d]'
  # set list-colors to enable filename colorizing
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
  zstyle ':completion:*' menu no
  # custom fzf flags
  # NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
  # zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2

  # NOTE: Ensure colors match by using FZF_DEFAULT_OPTS.
  zstyle ":fzf-tab:*" use-fzf-default-opts yes
  # NOTE: Preview file contents when tab completing directories.
  zstyle ":fzf-tab:complete:cd:*" fzf-preview "tree -C \${realpath} | head -50"
fi
