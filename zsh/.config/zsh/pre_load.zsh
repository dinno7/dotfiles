#! /usr/bin/env bash

setopt globdots

# NOTE: Load functions to has access to sourcefiles function
[ -s "$DINNO_ZSH_DIR/functions.zsh" ] && source "$DINNO_ZSH_DIR/functions.zsh"

# NOTE: load static envs
sourcefiles "$DINNO_ZSH_DIR/envs.zsh" "$DINNO_ZSH_DIR/paths.zsh"
