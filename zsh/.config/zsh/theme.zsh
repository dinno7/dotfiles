#! /usr/bin/env bash

# Define colors
blue="#89B4FA"
cyan="#7dcfff"
green="#73daca"
magenta="#bb9af7"
red="#f7768e"
yellow="#e0af68"
background="#1a1b26"
foreground="#a9b1d6"

# Define prompt segments

# Function to get OS icon dynamically
function get_os_icon() {
	local os_icon="" # Default to generic Linux icon

	if [[ -f /etc/os-release ]]; then
		. /etc/os-release
		case "$ID" in
		arch) os_icon="" ;;   # Arch icon
		ubuntu) os_icon="" ;; # Ubuntu icon
		debian) os_icon="" ;; # Ubuntu icon
		esac
	fi

	if [[ -z "$os_icon" ]]; then
		case "$(uname -s)" in
		Linux*) os_icon="" ;;           # Generic Linux icon
		Darwin*) os_icon="" ;;          # macOS icon
		CYGWIN* | MINGW*) os_icon="" ;; # Windows icon (Cygwin/MinGW)
		esac
	fi

	echo "$os_icon"
}

# Define prompt segments
function prompt_os() {
	local os_icon=$(get_os_icon)
	echo "%F{$foreground}$os_icon%f"
}

function prompt_user_host() {
	echo "%F{$blue}%n@%m%f"
}

function prompt_path() {
	echo "%F{$cyan}%~%f"
}

function prompt_git() {
	local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
	if [[ -n $branch ]]; then
		echo "%F{$green} $branch%f"
	fi
}

function prompt_exit_code() {
	if [[ $? -eq 0 ]]; then
		echo "%F{$magenta}
❯%f"
	else
		echo "%F{$red}
❯%f"
	fi
}

function prompt_python() {
	if [[ -n $VIRTUAL_ENV ]]; then
		echo "%F{$yellow} $(basename "$VIRTUAL_ENV") > %f"
	fi
}

# Define main prompt
PROMPT='$(prompt_os) $(prompt_user_host) $(prompt_path) $(prompt_git) $(prompt_exit_code) '

# Define right prompt
RPROMPT='$(prompt_python)'

# Define secondary prompt
PS2="%F{$magenta}❯❯ %f"

# Define transient prompt
PROMPT_COMMAND='
  if [[ $? -eq 0 ]]; then
    PROMPT="$(prompt_os) $(prompt_user_host) $(prompt_path) $(prompt_git) $(prompt_exit_code) "
  else
    PROMPT="$(prompt_os) $(prompt_user_host) $(prompt_path) $(prompt_git) %F{$red}❯%f "
  fi
'
