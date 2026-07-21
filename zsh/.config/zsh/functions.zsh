#! /usr/bin/env bash

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

function mdd() {
  local p="${1?Path not define}"
  mkdir -p "$p" || return 1
  cd "$p" || return 1
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

termproxy() {
  while true; do
    cat <<EOF
1) Enable local proxy
2) Enable proxy with host
3) Disable proxy
4) Status
5) Quite

EOF

    echo -n "Enter choice: "
    read user_choice
    printf '\033[1A\r\033[K'

    case "$user_choice" in
    1 | e)
      echo -n "Enter port: "
      read user_port

      if [ -z "$user_port" ]; then
        echo "Error: Port number is required for 'enable'"
        return 1
      fi
      if [ "$user_port" -lt 0 ] || [ "$user_port" -gt 65535 ]; then
        echo "Invalid port range, port must be 0-65535"
      else
        settermproxy "localhost" "$user_port"
        echo "Proxy enabled on localhost port $user_port"
      fi
      ;;
    2 | ee)
      echo -n "Enter host: "
      read user_host
      echo -n "Enter port: "
      read user_port

      if [ -z "$user_host" ]; then
        user_host="localhost"
      fi
      if [ -z "$user_port" ]; then
        echo "Error: Port number is required for 'enable'"
        return 1
      fi

      if [ "$user_port" -lt 0 ] || [ "$user_port" -gt 65535 ]; then
        echo "Invalid port range, port must be 0-65535"
      else
        settermproxy "$user_host" "$user_port"
        echo "Proxy enabled on $user_host port $user_port"
      fi
      ;;
    3 | d)
      unset all_proxy
      unset http_proxy
      unset https_proxy
      unset ALL_PROXY
      unset HTTP_PROXY
      unset HTTPS_PROXY
      echo "Proxy disabled"
      ;;
    4 | s)
      if [ -n "$all_proxy" ] || [ -n "$https_proxy" ] || [ -n "$https_proxy" ] || [ -n "$ALL_PROXY" ] || [ -n "$HTTP_PROXY" ] || [ -n "$HTTPS_PROXY" ]; then
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
      ;;
    5 | q)
      return 0
      ;;
    *)
      echo "\nPlease enter valid option!"
      ;;
    esac

    echo -n "\nPress enter to continue..."
    read
    clear
  done
}

settermproxy() {
  export all_proxy="http://$1:$2"
  export http_proxy="http://$1:$2"
  export https_proxy="http://$1:$2"
  export ALL_PROXY="http://$1:$2"
  export HTTP_PROXY="http://$1:$2"
  export HTTPS_PROXY="http://$1:$2"
}
