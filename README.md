# Dinno Dotfiles Setup

This repository contains a script to manage your dotfiles using symbolic links. It allows you to keep your configuration files organized and easily deploy them across different systems.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Backup](#backup)
- [Logging](#logging)

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

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/dotfiles.git $HOME/dinno.dotfiles
   ```

> [!NOTE]
> You should exactly clone it in `$HOME/dinno.dotfiles` because it is read the files from there in 'setup.sh'

2. **Make the Script Executable:**

```bash
chmod +x $HOME/dinno.dotfiles/setup.sh
```

## Configuration

The script uses a configuration file (`config.txt`) to manage dotfiles. This file should be placed in the $HOME/dinno.dotfiles directory and should contain lines in the format:
<PATH_IN_LOCAL_MACHINE>=<PATH_IN_DOTFILES_DIR>
For example:

```
.zshrc=.zshrc
.config/zsh=zsh/main.zsh
```

> [!WARNING]
> Please do not modify it if you do not know what are you doing

## Usage

1. Run the Setup Script:

```bash
$HOME/dinno.dotfiles/setup.sh
```

The script will:

- Read the config.txt file.
- Backup any existing files in the destination paths.
- Create symbolic links from the source files to the destination paths.

> [!TIP]
> Install Hack Nerd Font(or any nerd fonts) to support icons and have a better experience

## Backup

The script will backup any existing files to the `$HOME/dinno.dotfiles.bak` directory. This ensures that you don't lose your current configuration when deploying new dinno.dotfiles.

## Logging

The script logs all actions to a log file located at `$HOME/dinno.dotfiles.log`. This log file contains timestamps and detailed information about each operation performed by the script.
