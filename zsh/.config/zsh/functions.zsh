#! /usr/bin/env bash

# Add directories to the end of the path if they exist and are not already in the path
# Link: https://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
function pathappend() {
	for ARG in "$@"; do
		if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
			PATH="${PATH:+"$PATH:"}$ARG"
		fi
	done
}

# Add directories to the beginning of the path if they exist and are not already in the path
function pathprepend() {
	for ARG in "$@"; do
		if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
			PATH="$ARG${PATH:+":$PATH"}"
		fi
	done
}

function sourcefiles() {
	local ARG
	for ARG in "$@"; do
		if [ -s "$ARG" ]; then
			source "$ARG"
		fi
	done
}

function runfree() {
	"$@" >/dev/null 2>&1 &
	disown
}

function cmd_exists() {
	command -v "$1" >/dev/null 2>&1
}

# Alias to launch a document, file, or URL in it's default X application
if cmd_exists xdg-open; then
	function open() {
		local target
		if [ $# -eq 0 ]; then
			target="$PWD"
		else
			target="$@"
		fi
		runfree xdg-open "$target"
	}
fi

function mcd() {
	mkdir -p "$1"
	cd "$1" || exit
}

function ds() {
	du "$1" -h -d 1 | sort -hr
}

if cmd_exists yazi; then
	function y() {
		local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
		yazi "$@" --cwd-file="$tmp"
		IFS= read -r -d '' cwd <"$tmp"
		[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd" || exit
		rm -f -- "$tmp"
	}
fi

if cmd_exists bw; then
	function bwunlock() {
		if ! cmd_exists pass; then
			echo "the bitwarden master key should main in pass, the pass is not installed"
			return 1
		fi
		if ! cmd_exists bw; then
			echo "please install bitwarden-cli first"
			return 1
		fi
		export BW_PASSWORD="$(pass main/bw)"
		local _bw_session="$(bw unlock --passwordenv BW_PASSWORD --raw)"
		export BW_SESSION=$_bw_session
		unset BW_PASSWORD
		echo "Vault is now unlocked!"
	}
fi

function get_ips() {
	cat "$1" | grep -Po "(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}" | head -n "$2" | xargs | sed "s/ /,/g"
}

function ips_test() {
	tail -n +2 "$1" | cut -d',' -f1 | uniq | xargs -I{} bash -c 'ping -c1 -W1 {} >/dev/null && echo {}'
}

# NOTE: Function to log messages
function clog() {
	if [[ -z $1 ]]; then
		return
	fi
	echo "ℹ️ $(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$DINNO_ZSH_LOGS"
}

# NOTE: Commands cheatsheet
function how() {
	if [[ -z $1 ]]; then
		echo "Please provide command in first arg"
		return
	fi
	if ! cmd_exists curl; then
		echo "Please install curl first"
		return
	fi

	curl -s "cheat.sh/$1" | cat
}

# NOTE: Getting weather
function weather() {
	CITY="${1:-tehran}"
	curl "wttr.in/$CITY"
}

# NOTE: Sharing local port to internet
function shareport() {
	ssh -R "80:localhost:$1" localhost.run
}

function shareportsafe() {
	if ! cmd_exists lt; then
		echo "please install Localtunnel first"
		return 1
	fi

	lt --port "$1" --print-requests -o -s "dinno-$(date +%s)"
}

function omz_plugin_get {
	local repo_path="${1}"
	local project="$(echo "${repo_path}" | cut -d"/" -f2)"
	local project_path="$ZSH_CUSTOM/plugins/$project"

	if cd "${project_path}" >/dev/null 2>&1; then
		echo "Updating ${repo_path}..."
		git pull
		cd - >/dev/null 2>&1 || exit
	else
		echo "Installing ${repo_path}..."
		git clone "https://github.com/${repo_path}" "${project_path}"
	fi
}

function omz_plugin_sync {
	local OMZ_PLUGINS=(
		"Aloxaf/fzf-tab"
		"jeffreytse/zsh-vi-mode"
		"zsh-users/zsh-autosuggestions"
		"MichaelAquilina/zsh-you-should-use"
		"zdharma-continuum/fast-syntax-highlighting"
	)
	echo "Syncing 3-party's oh-my-zsh plugins"
	for plugin in "${OMZ_PLUGINS[@]}"; do
		echo "---------- Syncing $plugin ----------"
		omz_plugin_get "$plugin"
		echo
	done
}
