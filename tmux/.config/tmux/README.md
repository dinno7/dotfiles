# The Dinno tmux config file

# Installation

0. Set $TMUX_CONFIG_DIR on your shell configuration, The suggest path is `$HOME/.config/tmux`

1. Take a backup from your tmux config if exist

```bash
mv $TMUX_CONFIG_DIR $TMUX_CONFIG_DIR.bak
```

2. Clone the configuration

```bash
git clone https://github.com/dinno7/tmux.git "$TMUX_CONFIG_DIR"
```

3. open shell with tmux

```bash
tmux
```

then install plugins with `<CTRL-I>`

> [!NOTE] Please notice that all main configuration are exists in `$TMUX_CONFIG_DIR/tmux.conf` file

### The default prefix is `<CTRL-a>`

# Theme configuration

Every theme need it's own Installation stuff
i consider themes configuration files in `$TMUX_CONFIG_DIR/themes/` directory, the cattpuccin, tokyo-night, nord are exists there by default and tokyo-night consider as default theme.
if you want add more theme, you should first install the theme and then put the configuration file in `themes` directory, then go to `tmux.conf` and source it in end of the file.
