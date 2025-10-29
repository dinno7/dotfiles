# NOTE: Run tmux session
if [[ -z $TMUX && $SHLVL -eq 1 ]]; then
  echo "Start Tmux..."
  session_name="Dinno"
  tmux attach -t "$session_name" || tmux new -s "$session_name"
fi

if [[ -n $TMUX && $SHLVL -eq 2 ]]; then
  if [ $(command -v fastfetch) ]; then
    fastfetch --logo $DINNO_ZSH_LOGO
  elif [ $(command -v neofetch) ]; then
    neofetch --source $DINNO_ZSH_LOGO
  else
    cat -p $DINNO_ZSH_LOGO
  fi
fi

# NOTE: Automatically run nvm use when entering a directory if it contains a .nvm file.
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc


