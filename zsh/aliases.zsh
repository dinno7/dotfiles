# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh

alias c='clear'
alias cls='clear'
alias e='exit'
alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmdir='rmdir -v'
alias grep='grep --color=auto'
alias src="source $HOME/.zshrc"
alias nv='nvim'
alias zs="nvim $HOME/.config/zsh/custom.zsh"


alias get_clean_ip="bash <(curl -fsSL https://raw.githubusercontent.com/Ptechgithub/warp/main/endip/install.sh)"

if [[ -x "$(command -v xclip)" ]]; then
  alias cpc="xclip -sel clip"
fi

# Alias to launch a document, file, or URL in it's default X application
if [[ -x "$(command -v xdg-open)" ]]; then
	alias open='runfree xdg-open'
fi

function runfree() {
	"$@" > /dev/null 2>&1 & disown
}

# Alias for lsd
if [[ -x "$(command -v lsd)" ]]; then
  alias ll='lsd -ltahAF --group-directories-first'
  alias lld='lsd -ltahA -d */'
	alias tree='lsd --tree'
else
  alias ll='ls -ltahAF --group-directories-first'
fi

# Alias For bat
# Link: https://github.com/sharkdp/bat
if [[ -x "$(command -v bat)" ]]; then
    alias cat='bat'
fi

# Alias for lazygit
# Link: https://github.com/jesseduffield/lazygit
if [[ -x "$(command -v lazygit)" ]]; then
    alias lg='lazygit'
fi

# Alias for FZF
# Link: https://github.com/junegunn/fzf
if [[ -x "$(command -v fzf)" ]]; then
    alias fzf='fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'
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

mcd (){
  mkdir -p $1
  cd $1
}

ds (){
  du $1 -h -d 1  | sort -hr
}

get_ips (){
 cat $1 | grep -Po "(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}" | head -n $2 | xargs | sed "s/ /,/g"
}
