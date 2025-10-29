alias c="clear"
alias cls="clear"
alias e="exit"
alias mkdir="mkdir -pv"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias rmdir="rmdir -v"
alias grep="grep --color=auto"
alias src="source $HOME/.zshrc"
alias nv="nvim"
alias zs="nv $DINNO_ZSH_DIR/main.zsh"
alias nvc="nv $DINNO_NVIM_DIR"
alias ll="ls -ltahAF --group-directories-first"
alias lld="ls -ltahA -d"
alias gpo="git push origin"
alias wz="wezterm"
alias get_clean_ip="bash <(curl -fsSL https://raw.githubusercontent.com/Ptechgithub/warp/main/endip/install.sh)"


# NOTE: -- Conditional aliases --
#
if [[ -x "$(command -v xclip)" ]]; then
  alias cpc="xclip -sel clip"
fi

# Alias to launch a document, file, or URL in it's default X application
if [[ -x "$(command -v xdg-open)" ]]; then
  alias open='runfree xdg-open'
fi

# Alias for lsd
if [[ -x "$(command -v lsd)" ]]; then
  alias ls="lsd"
  alias tree='lsd --tree'
fi

# Alias For bat
# Link: https://github.com/sharkdp/bat
if command -v batcat >/dev/null 2>&1; then
  alias rcat="$(which cat)"
  alias cat="$(which batcat)"
elif command -v bat >/dev/null 2>&1; then
  alias rcat="$(which cat)"
  alias cat="$(which bat)"
fi

# Alias for lazygit
# Link: https://github.com/jesseduffield/lazygit
if [[ -x "$(command -v lazygit)" ]]; then
  alias lg='lazygit'
fi

# Alias for FZF
# Link: https://github.com/junegunn/fzf
if [[ -x "$(command -v fzf)" ]]; then
  # Alias to fuzzy find files in the current folder(s), preview them, and launch in an editor
  if [[ -x "$(command -v xdg-open)" ]]; then
    alias preview='open $(fzf --info=inline --query="${@}")'
  else
    alias preview='edit $(fzf --info=inline --query="${@}")'
  fi
fi

# Get local IP addresses
if [[ -x "$(command -v ip)" ]]; then
  alias iplocal="ip -br -c a"
else
  alias iplocal="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
fi

# Get public IP addresses
if [[ -x "$(command -v curl)" ]]; then
  alias myipshow='curl -s http://ip-api.com/line'
  alias myip='curl -s http://ip-api.com/line | grep -P --invert-match --line-buffered "(\d+\.?)+"'
elif [[ -x "$(command -v wget)" ]]; then
  alias myipshow='wget -qO- http://ip-api.com/line'
  alias myip='wget -qO- http://ip-api.com/line | grep -P --invert-match --line-buffered "(\d+\.?)+"'
fi
