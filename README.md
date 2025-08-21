# Dinno Dotfiles Setup

This repository contains a script to manage your dotfiles using symbolic links. It allows you to keep your configuration files organized and easily deploy them across different systems.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Backup](#backup)

## Prerequisites

### Required

- **Bash**: The script is written in Bash, so you need a Unix-like environment (Linux, macOS, etc.).
- **ZSH**: you should set bash to zsh
- **Oh-My-Zsh**: install the [OMZ](https://ohmyz.sh/#install) and below 3-party plugins
  - [you-should-use](https://github.com/MichaelAquilina/zsh-you-should-use)
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- **TPM**: For apply the tmux configutation and theme correctly, you should install [TPM](https://github.com/tmux-plugins/tpm) and then run `<C-I>` to install tmux packages, Please note that you should install tpm in `~/dinno.dotfiles/tmux/plugins/tpm`
  ```bash
  git clone https://github.com/tmux-plugins/tpm ~/dinno.dotfiles/tmux/plugins/tpm
  ```
- **`realpath` command**: This is used to generate relative paths for symlinks. It should be available on most modern Unix-like systems.

### Optional

- [fzf](https://github.com/junegunn/fzf#installation)
- [bat](https://github.com/sharkdp/bat)
- [lsd](https://github.com/lsd-rs/lsd)
- [fastfetch](https://github.com/fastfetch-cli/fastfetch)(Recommended) or [neofetch](https://github.com/dylanaraps/neofetch)

## Installation

0. **Install [stow](https://www.gnu.org/software/stow)**:

_Arch_

```bash
pacman -S stow
```

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/yourusername/dotfiles.git "$HOME/dotfiles"
   ```

2. **Sync**

   ```bash
   stow "$HOME/dotfiles"
   ```

> [!WARNING]
> Please do not modify it if you do not know what are you doing

> [!TIP]
> Install Hack Nerd Font(or any nerd fonts) to support icons and have a better experience

## Backup

It is the your's responsibility to back up existing configurations.
