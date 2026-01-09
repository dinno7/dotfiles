# NOTE: Add the most common personal binary paths located inside the home folder
# (these directories are only added if they exist)
pathprepend "$XDG_BIN_HOME" "$HOME/bin"

# NOTE: Add rust cargo
pathappend "$CARGO_HOME/bin"

# NOTE: Add Go to path
pathappend "/usr/local/go/bin" "$GOPATH/bin"

# NOTE: NVM
sourcefiles "$NVM_DIR/nvm.sh" "$NVM_DIR/bash_completion"

# NOTE: pnpm end
pathappend $PNPM_HOME
