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
    local target="${1:-$PWD}"
    runfree xdg-open "$target"
  }
fi

function mcd() {
  local path="${1?Path not define}"
  mkdir -p "$path"
  cd "$path" || exit
}

function ds() {
  du "${1:-$PWD}" -h -d 1 | sort -hr
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
    if [ -z "$BW_MASTER_PASSWORD" ]; then
      echo "The BW_MASTER_PASSWORD not set"
      return 1
    fi
    bw unlock --passwordenv BW_MASTER_PASSWORD --raw
    echo "Vault unlocked!"
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
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$DINNO_ZSH_LOGS"
}

function servehere() {
  local port="${1:-9009}"
  open http://localhost:$port
  python3 -m http.server $port
}

# NOTE: Commands cheatsheet
function how() {
  local cmd="${1?Please provide command in first arg}"
  if ! cmd_exists curl; then
    echo "Please install curl first"
    return 1
  fi
  echo "Getting $cmd tldr..."
  curl -s "cheat.sh/$cmd" | cat
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
  local shared_port="${1?Please pass port in first argument}"
  lt --port "$shared_port" --print-requests -o -s "dinno-$(date +%s)"
}

function viddown() {
  local URL="${1:?Please enter url}"
  local QUALITY="${2:-720}"
  local YTDLP_F="-f bestvideo[ext=mp4][height<=$QUALITY]+bestaudio[ext=m4a]/best[ext=mp4][height<=$QUALITY]/best --merge-output-format mp4"
  yt-dlp $YTDLP_F -o "$PWD/%(title)s.%(ext)s" "$URL"

}

function omz_plugin_sync {
  echo "Syncing 3-party's oh-my-zsh plugins"
  for plugin in "${OMZ_EXTERNAL_PLUGINS[@]}"; do
    echo "---------- Syncing $plugin ----------"
    omz_plugin_get "$plugin"
    echo
  done
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

function aicommitprompt() {
  echo -ne "$AI_PROMPT_GIT_COMMIT $(git diff --staged)"
}
