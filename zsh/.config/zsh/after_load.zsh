# NOTE: Run tmux session
if [[ -z $TMUX && $SHLVL -eq 1 ]]; then
  echo "Start Tmux..."
  session_name="Dinno"
  tmux attach -t "$session_name" || tmux new -s "$session_name"
fi

if [[ -n $TMUX && $SHLVL -eq 2 ]]; then
  if command -v fastfetch >/dev/null 2>&1; then
    fastfetch --logo $DINNO_ZSH_LOGO
  elif  command -v neofetch >/dev/null 2>&1; then
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

# NOTE: Ensure colors match by using FZF_DEFAULT_OPTS.
zstyle ":fzf-tab:*" use-fzf-default-opts yes
# NOTE: Preview file contents when tab completing directories.
zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls --color=always \${realpath}"


# NOTE: load main parts
# envs load again to do not overwritten with other apps
sourcefiles "$DINNO_ZSH_DIR/envs.zsh" "$DINNO_ZSH_DIR/dynamic_envs.zsh" "$DINNO_ZSH_DIR/aliases.zsh" "$DINNO_ZSH_DIR/theme.zsh" "$PATH_TERM_PROXY"

