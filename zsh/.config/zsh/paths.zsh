# NOTE: Add the most common personal binary paths located inside the home folder
# (these directories are only added if they exist)
pathprepend "$HOME/bin" "$HOME/sbin" "$HOME/.local/bin" "$HOME/local/bin" "$HOME/.bin"

# NOTE: pnpm end
pathappend $PNPM_HOME

# NOTE: Add rust stuff
pathappend "$HOME/.cargo/bin"

# NOTE: Add Go to path
pathappend "/usr/local/go/bin" "$GOPATH/bin"
