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
alias ll="ls -ltahAF --group-directories-first"
alias lld="ls -ltahA -d"
alias godown="shutdown now"


# NOTE: -- Conditional aliases --
if cmd_exists git; then
  alias gpo="git push origin"
  alias gplo="git pull origin"
fi

if cmd_exists opencode; then
  alias oc="opencode"
fi

if cmd_exists xclip; then
  alias cpc="xclip -sel clip -r"
fi

# Alias for lsd
if cmd_exists lsd; then
  alias ls="lsd"
  alias lt='lsd --tree --depth=2 --long --group-directories-first'
  alias tree='lt'
fi

if cmd_exists just; then
  alias js="just"
  alias jsc="just --choose"
fi


# Alias For bat
# Link: https://github.com/sharkdp/bat
if cmd_exists batcat; then
  alias rcat="$(which cat)"
  alias cat="$(which batcat)"
elif cmd_exists bat; then
  alias rcat="$(which cat)"
  alias cat="$(which bat)"
fi

# Alias for lazygit
# Link: https://github.com/jesseduffield/lazygit
if cmd_exists lazygit; then
  alias lg='lazygit'
fi

# Alias for FZF
# Link: https://github.com/junegunn/fzf
if cmd_exists fzf; then
  # Alias to fuzzy find files in the current folder(s), preview them, and launch in an editor
  if cmd_exists xdg-open; then
    alias preview='open $(fzf --info=inline --query="${@}")'
  else
    alias preview='edit $(fzf --info=inline --query="${@}")'
  fi
fi

# Get local IP addresses
if cmd_exists ip; then
  alias iplocal="ip -br -c a"
else
  alias iplocal="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
fi

# Get public IP addresses
if cmd_exists curl; then
  alias myipshow='curl -s http://ip-api.com/line'
  alias myip='curl -s http://ip-api.com/line | grep -P --invert-match --line-buffered "(\d+\.?)+"'
elif cmd_exists wget; then
  alias myipshow='wget -qO- http://ip-api.com/line'
  alias myip='wget -qO- http://ip-api.com/line | grep -P --invert-match --line-buffered "(\d+\.?)+"'
fi
