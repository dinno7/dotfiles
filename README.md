# Dinno Dotfiles Setup

This repository contains a script to manage your dotfiles using symbolic links. It allows you to keep your configuration files organized and easily deploy them across different systems.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Uninstall](#uninstall)

## Prerequisites

> [!TIP]
> Install [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip)(or any [nerd fonts](https://www.nerdfonts.com/font-downloads)) to support icons and have a better experience

### Required

- **Unix**: The script is written in Bash, so you need a Unix-like environment (Linux, macOS, etc.).
- **Alacaritty**: My favorite terminal emulator, you can install it from [here](https://github.com/alacritty/alacritty)
- **Neovim**: My favorite text editor, install from [here](https://github.com/neovim/neovim)
- **ZSH**: you should set bash to zsh
- **Oh-My-Zsh**: install the [OMZ](https://ohmyz.sh/#install) and below 3-party plugins
  - [you-should-use](https://github.com/MichaelAquilina/zsh-you-should-use)
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- **Tmux**: Install from [tmux](https://github.com/tmux/tmux)
- **TPM**: For apply the tmux configutation and theme correctly, you should install [TPM](https://github.com/tmux-plugins/tpm) and then run `<C-I>` to install tmux packages, Please note that you should install tpm in `~/dotfiles/tmux/plugins/tpm`
- **wl-clipboard(wayland) or xclip(xorg)**: for copy & paste support in terminal
- **Git Delta**: install [delta](https://github.com/dandavison/delta) to see better diff in `git diff` and `lazygit`

##### Please refer to the original document for using [TPM](https://github.com/tmux-plugins/tpm), but the installation is done with the command below in the latest update of this repository.

```bash
  git clone https://github.com/tmux-plugins/tpm ~/dotfiles/.config/tmux/plugins/tpm
```

### Optional

- [pass](https://www.passwordstore.org)
- [fzf](https://github.com/junegunn/fzf#installation)
- [bat](https://github.com/sharkdp/bat)
- [lsd](https://github.com/lsd-rs/lsd)
- [fastfetch](https://github.com/fastfetch-cli/fastfetch)(Recommended) or [neofetch](https://github.com/dylanaraps/neofetch)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [yazi](https://github.com/sxyazi/yazi)
- [Überzug++](https://github.com/jstkdng/ueberzugpp): for support image preview in yazi(alacritty)

> [!WARNING]
> Please do not modify it if you do not know what are you doing
> It is the your's responsibility to back up existing configurations.

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
    cd $HOME/dotfiles && stow */ && source $HOME/.zshrc
   ```

## Uninstall

```bash
    cd $HOME/dotfiles && stow -D */
```
