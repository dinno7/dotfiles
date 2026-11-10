#! /usr/bin/env bash

alias c="clear"
alias cls="clear"
alias e="exit"
alias mkdir="mkdir -pv"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias rd="rm -riv"
alias rmdir="rmdir -v"
alias grep="grep --color=auto"
alias src="source $HOME/.zshrc"
alias v="$EDITOR"
alias vc="$EDITOR $DINNO_NVIM_DIR"
alias zs="$EDITOR $DINNO_ZSH_DIR/main.zsh"
alias godown="shutdown now"

# NOTE: -- Conditional aliases --
if cmd_exists git; then
  alias gpo="git push origin"
  alias gplo="git pull origin"
fi

if cmd_exists wl-copy; then
  alias cpc="wl-copy"
elif cmd_exists xclip; then
  alias cpc="xclip -sel clip -r"
fi

# Alias for lsd
if cmd_exists lsd; then
  alias rls="/usr/bin/ls"
  alias ls="lsd"
  alias ll="ls -ltahAF --group-dirs=first"
  alias lld="ls -ltahA -d */"
  if ! cmd_exists tree; then
    alias tree='lsd --tree --depth=2 --long --group-dirs=first'
  fi
else
  alias ll="ls -ltahAF --group-directories-first --color=auto"
  alias lld="ls -ltahA -d --color=auto */"
fi

if cmd_exists just; then
  alias j="just"
  alias jc="just --choose"
fi

# Alias For bat
# Link: https://github.com/sharkdp/bat
# NOTE: ${commands[...]} is zsh's command hash table: no subshell/fork, and it
# keeps pointing to the real binary even if `cat` is already aliased (e.g. `src`)
if cmd_exists batcat; then
  alias rcat="${commands[cat]}"
  alias cat="${commands[batcat]}"
elif cmd_exists bat; then
  alias rcat="${commands[cat]}"
  alias cat="${commands[bat]}"
fi

# Alias for lazygit
# Link: https://github.com/jesseduffield/lazygit
if cmd_exists lazygit; then
  alias lg='lazygit'
fi

# Get local IP addresses
if cmd_exists ip; then
  alias ipl="ip -br -c a"
else
  alias ipl="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
fi

# Get public IP addresses
if cmd_exists xh; then
  alias myipshow='xh --body http://ip-api.com/json'
  alias myip='xh --body --pretty=all http://ip-api.com/json | grep -Pv "query.+"'
elif cmd_exists curl; then
  alias myipshow='curl -s http://ip-api.com/line'
  alias myip='curl -s http://ip-api.com/line | grep -P --invert-match --line-buffered "(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}"'
elif cmd_exists wget; then
  alias myipshow='wget -qO- http://ip-api.com/line'
  alias myip='wget -qO- http://ip-api.com/line | grep -P --invert-match --line-buffered "(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}"'
fi

if cmd_exists kubectl; then
  alias ktl="kubectl"
fi

# AI
if cmd_exists cursor-agent; then
  if cmd_exists cursor; then
    alias cursordesktop="cursor"
  fi
  alias cursor="cursor-agent"
fi

if cmd_exists opencode; then
  alias oc="opencode"
fi
