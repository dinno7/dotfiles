# zsh Options
setopt HIST_IGNORE_ALL_DUPS

PATH_ZSH_CUSTOM="$HOME/.config/zsh/main.zsh"
PATH_ZSH_ALIASES="$HOME/.config/zsh/aliases.zsh"

# Custom zsh
[ -f $PATH_ZSH_CUSTOM ] && source $PATH_ZSH_CUSTOM

# Aliases
[ -f $PATH_ZSH_ALIASES ] && source $PATH_ZSH_ALIASES
