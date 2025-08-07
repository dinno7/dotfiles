#!/bin/bash

# Define paths
DOTFILES_DIR="$HOME/dinno.dotfiles"
BACKUP_DIR="$HOME/dinno.dotfiles.bak"
LOG_FILE="$HOME/dinno.dotfiles.log"

# Configuration file
CONFIG_FILE="$DOTFILES_DIR/config.txt"

# Function to log messages
log() {
  echo "ℹ️ $(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Function to backup existing files
backup_file() {
  local file="$1"
  local backup_path="$BACKUP_DIR/$(basename "$file")"
  mv "$file" "$backup_path"
  log "Backed up existing $file to $backup_path"
}

# Function to create a symlink
create_symlink() {
  local src="$1"
  local dest="$2"
  local rel_path

  # Use relative path for the symlink
  rel_path=$(realpath --relative-to="$(dirname "$dest")" "$src")

  # Check if the destination already exists
  if [ -e "$dest" ]; then
    if [ -L "$dest" ]; then
      log "Skipping $dest as it is already a symlink."
      return
    fi
    log "Existing file found at $dest. Backing it up."
    backup_file "$dest"
  fi

  # Create the symlink
  ln -s "$rel_path" "$dest"
  log "Linked $src to $dest"
}

# Check if the configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
  log "Configuration file $CONFIG_FILE not found. Exiting."
  exit 1
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Read the configuration file and process each entry
while IFS='=' read -r dest src; do
  if [ -z "$dest" ] || [ -z "$src" ]; then
    log "Skipping invalid entry: $dest=$src"
    continue
  fi

  src="$DOTFILES_DIR/$src"
  dest="$HOME/$dest"

  if [ ! -e "$src" ]; then
    log "Source file $src does not exist. Skipping."
    continue
  fi

  create_symlink "$src" "$dest"
done <"$CONFIG_FILE"

log "Dotfiles installation complete!"
