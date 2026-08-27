#! /usr/bin/env bash

set -euo pipefail

NC='\033[0m'
BLUE='\033[0;34m'
YELLOW='\e[33m'
BOLD_BLUE='\033[1;34m'
BOLD_GREEN='\033[1;32m'
BOLD_RED='\033[1;31m'

echo_info_bold() {
  echo -e "[INFO] - ${BOLD_BLUE}$*${NC}"
}
echo_info() {
  echo -e "[INFO] - ${BLUE}$*${NC}"
}
echo_warn() {
  echo -e "[WARN] - ${YELLOW}$*${NC}"
}
echo_success() {
  echo -e "[INFO] - ${BOLD_GREEN}$*${NC}"
}
echo_error() {
  echo -e "[ERROR] - ${BOLD_RED}$*${NC}"
}

function cmd_exists() {
  command -v "$1" >/dev/null 2>&1
}

get_input() {
  local prompt="$1"
  local variable_name="$2"
  local input_value

  read -p "$prompt " input_value
  eval "$variable_name='$input_value'"
}

get_bool() {
  local prompt="$1"
  get_input "${prompt}[y/n] " ans
  ans="$(echo "$ans" | tr '[:upper:]' '[:lower:]')"
  if [ "$ans" == "y" ]; then
    return 0
  fi
  return 1
}

ensure_stow_installed() {
  # Check if stow is installed
  echo_info "Checking stow existence..."
  if cmd_exists stow; then
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

get_all_modules() {
  find "${1:-$PWD}" \
    -maxdepth 1 \
    -type d \
    -not -name '.git' -and -not -name '_' \
    -printf "%P "
}

stow_all() {
  echo_info_bold "Stowing command line tool configuration modules"
  CMD_MODULES="$(get_all_modules)"
  for module in $CMD_MODULES; do
    if cmd_exists "$module"; then
      stow --target="$HOME" "$module"
      echo_success "$module stowed successfully"
    else
      echo_warn "$module is not installed - [ignored]"
    fi
  done

  if [ -d '_' ]; then
    echo "---"
    echo_info_bold "Stowing not command modules"
    NOT_TOOL_MODULES="$(get_all_modules './_')"
    stow --target="$HOME" --dir="./_" $NOT_TOOL_MODULES
    echo_info "$(echo $NOT_TOOL_MODULES | tr ' ' ', ') stowed successfully"
  fi
}

unstow_all() {
  echo_info_bold "Unstowing command line tool configuration modules"
  CMD_MODULES="$(get_all_modules)"
  for module in $CMD_MODULES; do
    if cmd_exists "$module"; then
      stow --target="$HOME" -D "$module"
      echo_success "$module stowed successfully"
    else
      echo_warn "$module is not installed - [ignored]"
    fi
  done

  if [ -d '_' ]; then
    echo "---"
    echo_info_bold "Stowing not command modules"
    NOT_TOOL_MODULES="$(get_all_modules './_')"
    stow --target="$HOME" --dir="./_" -D $NOT_TOOL_MODULES
    echo_info "$(echo $NOT_TOOL_MODULES | tr ' ' ', ') stowed successfully"
  fi
}

install_yay() {
  local clone_path="/tmp/yay"
  git clone https://aur.archlinux.org/yay.git "$clone_path"
  cd "$clone_path"
  makepkg -si && yay -Y --gendb && yay -Syu --devel && yay -Y --devel --save
  cd -
}

pkgs=("pipewire" "wireplumber" "pipewire-audio" "pipewire-pulse" "pipewire-alsa" "pipewire-jack" "pavucontrol" "alacritty" "zsh" "git" "base" "base-devel" "wget" "curl" "tmux" "neovim" "ncdu" "man-db" "man-pages" "less" "vim" "stow" "rsync" "reflector" "starship" "vlc" "vlc-plugins-all" "zoxide" "lazygit" "bat" "btop" "docker" "docker-buildx" "yazi" "lsd" "ripgrep" "fd" "fzf" "unzip" "unrar" "tree" "tree-sitter-cli" "dnsutils" "netcat" "just" "xclip" "xh" "uv" "obsidian" "jq" "git-delta" "fnm" "fastfetch" "ark" "7zip" "google-chrome" "noto-fonts" "noto-fonts-cjk" "noto-fonts-emoji" "ttf-jetbrains-mono-nerd" "easydocker-bin" "lazyssh-bin" "lazysql-bin" "throne-bin" "telegram-desktop-bin" "opencode-bin" "localsend-bin" "git-open" "bruno-bin" "visual-studio-code-bin")
install_dependencies() {
  if get_bool "Do you want update mirrors?"; then
    echo_info "Getting last 10 mirrors..."
    sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
    sudo reflector --fastest 20 --download-timeout 1 --thread 10 --save /etc/pacman.d/mirrorlist
  fi

  sudo pacman -Syyy --noconfirm

  if ! cmd_exists yay; then
    echo_info "Installing yay..."
    install_yay
    echo_info "yay installed"
  fi
  yayInstallCmd="yay -S --needed --noconfirm ${pkgs[*]}"
  eval "$yayInstallCmd"
  fc-cache -fv
}

echo_info_bold "Please select one of the below options"
subCommands=("Stow all" "Unstow all" "Install Dependencies" "Exit")
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
  "Install Dependencies")
    echo "-----------------"
    install_dependencies
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
