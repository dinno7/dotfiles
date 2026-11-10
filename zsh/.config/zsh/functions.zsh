#! /usr/bin/env bash

function runfree() {
  "$@" >/dev/null 2>&1 &
  disown
}

# Open regular files in $EDITOR, anything else (dir, URL, ...) with the default app
if cmd_exists xdg-open; then
  function open() {
    local target="${1:-$PWD}"
    if [[ -f "$target" ]]; then
      ${=EDITOR} "$target"
    else
      runfree xdg-open "$target"
    fi
  }
fi

function mdd() {
  local p="${1?Path not define}"
  mkdir -p "$p" || return 1
  cd "$p" || return 1
}

function dud() {
  du -shx "${*:-.}"/* | sort -hr
}

if cmd_exists yazi; then
  function y() {
    local tmp cwd
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd <"$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
    command rm -f -- "$tmp"
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
  command grep -Po "(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}" -- "$1" | head -n "$2" | xargs | sed "s/ /,/g"
}

function ips_test() {
  tail -n +2 "$1" | cut -d',' -f1 | uniq | xargs -I{} bash -c 'ping -c1 -W1 {} >/dev/null && echo {}'
}

# NOTE: Function to log messages
function clog() {
  if [[ -z $1 ]]; then
    return
  fi
  mkdir -p -- "${DINNO_ZSH_LOGS:h}"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $*" | tee -a "$DINNO_ZSH_LOGS"
}

function servehere() {
  local port="${1:-9009}"
  open "http://localhost:$port"
  python3 -m http.server "$port"
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
  local city="${1:-tehran}"
  curl "wttr.in/$city"
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

function shbng() {
  local filename="${1:?Please enter file name in first arg}"
  if [[ "$filename" != *.sh ]]; then
    filename="$filename.sh"
  fi
  cat <<EOF >"$filename"
#! /bin/bash

set -euo pipefail
EOF

  chmod +x "$filename"
}

function viddown() {
  if ! cmd_exists yt-dlp; then
    echo "Please install yt-dlp first"
    return 1
  fi
  local URL="${1:?Please enter url}"
  local QUALITY="${2:-720}"
  # NOTE: zsh does not word-split unquoted variables, so keep the args in an array
  local -a ytdlp_args=(
    -f "bestvideo[ext=mp4][height<=$QUALITY]+bestaudio[ext=m4a]/best[ext=mp4][height<=$QUALITY]/best"
    --merge-output-format mp4
    -o "$PWD/%(title)s.%(ext)s"
  )
  echo "yt-dlp ${(q)ytdlp_args[@]} ${(q)URL}"
  yt-dlp "${ytdlp_args[@]}" "$URL"
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
  local project="${repo_path##*/}"
  local project_path="$ZSH_CUSTOM/plugins/$project"

  if [ -d "${project_path}" ]; then
    echo "Updating ${repo_path}..."
    git -C "${project_path}" pull
  else
    echo "Installing ${repo_path}..."
    git clone "https://github.com/${repo_path}" "${project_path}"
  fi
}

function catrecursive() {
  local p="${1-$PWD}"
  find "$p" -type f -print0 | while IFS= read -r -d '' f; do
    printf '\n===== %s =====\n' "$f"
    command cat -- "$f"
  done
}

function aicommitprompt() {
  # NOTE: printf, not `echo -e` (zsh's echo would interpret backslashes inside the diff)
  printf '%s %s' "$AI_PROMPT_GIT_COMMIT" "$(git diff --staged)"
}

incognito() {
  if [ -n "$ZSH_VERSION" ]; then
    echo "[incognito] Entering isolated zsh session. Type 'exit' or ctrl-d to return."
    HISTFILE=/dev/null SAVEHIST=0 HISTSIZE=0 \
      ZDOTDIR=/dev/null zsh --no-rcs -i
  elif [ -n "$BASH_VERSION" ]; then
    echo "[incognito] Entering isolated bash session. Type 'exit' to return."
    HISTFILE=/dev/null HISTSIZE=0 \
      bash --norc --noprofile -i
  else
    echo "incognito: unsupported shell" >&2
    return 1
  fi
  echo "[incognito] Returned to normal shell."
}

termproxy() {
  _set_term_proxy() {
    export all_proxy="http://$1:$2"
    export http_proxy="http://$1:$2"
    export https_proxy="http://$1:$2"
    export ALL_PROXY="http://$1:$2"
    export HTTP_PROXY="http://$1:$2"
    export HTTPS_PROXY="http://$1:$2"
  }

  _unset_term_proxy() {
    unset all_proxy http_proxy https_proxy ALL_PROXY HTTP_PROXY HTTPS_PROXY
    echo "Proxy disabled"
  }

  _show_proxy_status() {
    if [ -n "$all_proxy" ] || [ -n "$http_proxy" ] || [ -n "$https_proxy" ] ||
      [ -n "$ALL_PROXY" ] || [ -n "$HTTP_PROXY" ] || [ -n "$HTTPS_PROXY" ]; then
      echo "Proxy is currently enabled"
      [ -n "$all_proxy" ] && echo "all_proxy: $all_proxy"
      [ -n "$http_proxy" ] && echo "http_proxy: $http_proxy"
      [ -n "$https_proxy" ] && echo "https_proxy: $https_proxy"
      [ -n "$ALL_PROXY" ] && echo "ALL_PROXY: $ALL_PROXY"
      [ -n "$HTTP_PROXY" ] && echo "HTTP_PROXY: $HTTP_PROXY"
      [ -n "$HTTPS_PROXY" ] && echo "HTTPS_PROXY: $HTTPS_PROXY"
    else
      echo "Proxy is currently disabled"
    fi
    echo "Getting ip..."
    curl -s 'http://ip-api.com/line'
  }

  _print_help() {
    echo "Usage: termproxy [-p port] [-h host] | [-d] | [-s]"
  }

  # If arguments were passed, parse flags and exit without looping
  if [ $# -gt 0 ]; then
    local OPTIND opt host port
    host="localhost"
    while getopts "p:h:ds" opt; do
      case "$opt" in
      p) port="$OPTARG" ;;
      h) host="$OPTARG" ;;
      d)
        _unset_term_proxy
        return 0
        ;;
      s)
        _show_proxy_status
        return 0
        ;;
      *)
        _print_help
        return 1
        ;;
      esac
    done

    if [ -n "$port" ]; then
      if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -gt 65535 ]; then
        echo "Invalid port range, port must be 0-65535"
        return 1
      fi
      _set_term_proxy "$host" "$port"
      echo "Proxy enabled on $host port $port"
      return 0
    else
      echo "Error: Port number (-p) is required to enable proxy."
      return 1
    fi
  else
    _print_help
    return 1
  fi
}
