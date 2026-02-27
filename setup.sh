#! /usr/bin/env bash

set -euo pipefail

NC='\033[0m'
BLUE='\033[0;34m'
BOLD_BLUE='\033[1;34m'
BOLD_GREEN='\033[1;32m'
BOLD_RED='\033[1;31m'

echo_info_bold() {
  echo -e "${BOLD_BLUE}$@${NC}"
}
echo_info() {
  echo -e "${BLUE}$@${NC}"
}
echo_success() {
  echo -e "${BOLD_GREEN}$@${NC}"
}
echo_error() {
  echo -e "${BOLD_RED}$@${NC}"
}

ensure_stow_installed() {
  # Check if stow is installed
  echo_info "Checking stow existence..."
  if command -v stow &>/dev/null; then
    echo_info "stow is already installed."
  else
    echo_info "stow is not installed"
    echo_info "Checking your OS..."
    # Determine the OS and install stow accordingly
    if [ -f /etc/debian_version ]; then
      echo_info "Detected Debian-based system. Installing stow..."
      sudo apt update && sudo apt install -y stow
    elif [ -f /etc/arch-release ]; then
      echo_info "Detected Arch-based system. Installing stow..."
      sudo pacman -Syu stow
    else
      echo_error "Unsupported OS. Please install stow manually then try again"
      exit 1
    fi
  fi
}

get_all_pkgs() {
  find $PWD -maxdepth 1 -type d -not -name '.git' -printf "%P "
}

stow_all() {
  local ALL_PKGS="$(get_all_pkgs)"
  stow $ALL_PKGS
  echo_info "$(echo $ALL_PKGS | tr ' ' '\n')"
  echo_success "Stowed successfully"
}

unstow_all() {
  local ALL_PKGS="$(get_all_pkgs)"
  stow -D $ALL_PKGS
  echo_info "$(echo $ALL_PKGS | tr ' ' '\n')"
  echo_success "Unstowed successfully"
}

echo_info_bold "Please select one of the below options"
subCommands=("Stow all" "Unstow all" "Exit")
select subcmd in "${subCommands[@]}"; do
  case "$subcmd" in
  "Stow all")
    ensure_stow_installed
    echo "-----------------"
    stow_all
    exit 0
    ;;
  "Unstow all")
    ensure_stow_installed
    echo "-----------------"
    unstow_all
    exit 0
    ;;
  "Exit")
    exit 0
    ;;
  "")
    echo_error "Not valid option, please choose currect option"
    ;;
  esac
done
