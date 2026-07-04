#! /usr/bin/env bash

# NOTE: Add the most common personal binary paths located inside the home folder
# (these directories are only added if they exist)
pathprepend "$XDG_BIN_HOME" "$HOME/bin" "$NVIM_DATA_DIR/mason/bin"

# NOTE: pnpm
pathprepend "$PNPM_HOME"

# NOTE: Add Go to path
pathprepend "/usr/local/go/bin" "$GOPATH/bin"

# NOTE: Add rust cargo
pathprepend "$CARGO_HOME/bin"
