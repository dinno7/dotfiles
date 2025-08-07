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

- **Bash**: The script is written in Bash, so you need a Unix-like environment (Linux, macOS, etc.).
- **`realpath` command**: This is used to generate relative paths for symlinks. It should be available on most modern Unix-like systems.
- Oh-My-Zsh: you can install it from [here](https://ohmyz.sh/#install).

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

> [!NOTE] Install Hack Nerd Font(or any nerd fonts) to support icons and have a better experience

## Backup

The script will backup any existing files to the `$HOME/dinno.dotfiles.bak` directory. This ensures that you don't lose your current configuration when deploying new dinno.dotfiles.

## Logging

The script logs all actions to a log file located at `$HOME/dinno.dotfiles.log`. This log file contains timestamps and detailed information about each operation performed by the script.
