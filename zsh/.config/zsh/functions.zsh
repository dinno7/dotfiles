# Add directories to the end of the path if they exist and are not already in the path
# Link: https://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
function pathappend() {
  for ARG in "$@"
  do
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
      PATH="${PATH:+"$PATH:"}$ARG"
    fi
  done
}

# Add directories to the beginning of the path if they exist and are not already in the path
function pathprepend() {
  for ARG in "$@"
  do
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
  "$@" > /dev/null 2>&1 & disown
}

function cmd_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Alias to launch a document, file, or URL in it's default X application
if [[ -x "$(command -v xdg-open)" ]]; then
  function open(){
    local target
    if [ $# -eq 0 ]; then
      target="$PWD"
    else
      target="$@"
    fi
    runfree xdg-open $target
  }
fi

function mcd(){
  mkdir -p $1
  cd $1
}

function ds(){
  du $1 -h -d 1  | sort -hr
}


function bwunlock(){
  if [[ ! -n "$BW_PASSWORD" ]];then
    echo "please set bitwarden master key to BW_PASSWORD"
    return 1
  fi
  if ! command -v bw >/dev/null 2>&1;then
    echo "please install bitwarden-cli first"
    return 1
  fi
  local _bw_session="$(bw unlock --passwordenv BW_PASSWORD --raw)"
  export BW_SESSION=$_bw_session
  echo "Vault is now unlocked!"
}

function get_ips (){
  cat $1 | grep -Po "(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}" | head -n $2 | xargs | sed "s/ /,/g"
}

function ips_test() {
  tail -n +2 $1 | cut -d',' -f1 | uniq | xargs -I{} bash -c 'ping -c1 -W1 {} >/dev/null && echo {}'
}

# NOTE: Function to log messages
function clog() {
  if [[ -z $1 ]];then
    return
  fi
  echo "ℹ️ $(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$DINNO_ZSH_LOGS"
}

# NOTE: Commands cheatsheet
function how(){
  if [[ -z $1 ]];then
    echo "Please provide command in first arg"
    return
  fi
  if [ ! -x "$(command -v curl)" ];then
    echo "Please install curl first"
    return
  fi

  curl -s "cheat.sh/$1" | cat
}

# NOTE: Getting weather
function weather(){
  CITY="${1:-tehran}"
  curl "wttr.in/$CITY"
}

# NOTE: Sharing local port to internet
function shareport(){
  ssh -R "80:localhost:$1" localhost.run
}

function shareportsafe(){
  if [[ -x "$(command -v lt)" ]]; then
    lt --port $1 --print-requests -o -s "dinno-$(date +%s)"
  else
    echo "Please install Localtunnel first"
    exit 1
  fi
}
