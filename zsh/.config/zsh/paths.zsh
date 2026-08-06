#! /usr/bin/env bash

# INFO: Add the most common personal binary paths located inside the home folder
# (these directories are only added if they exist)

export PATH=""

# INFO: Add rust cargo
pathappend "$CARGO_HOME/bin"

# INFO: Add Go to path
pathappend "/usr/local/go/bin" "$GOPATH/bin"

# INFO: pnpm
pathappend "$PNPM_HOME"

# INFO: System/User(pkg manager) installed bin
pathappend "$HOME/bin" "$XDG_BIN_HOME"
pathappend "/usr/local/bin" "/usr/bin" "/bin" "/usr/local/sbin" "/usr/sbin" "/sbin"

# INFO: Nvim's mason bin
pathappend "$NVIM_DATA_DIR/mason/bin"
