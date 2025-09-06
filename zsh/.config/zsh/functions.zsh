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

function runfree() {
	"$@" > /dev/null 2>&1 & disown
}

function mcd(){
  mkdir -p $1
  cd $1
}

function ds(){
  du $1 -h -d 1  | sort -hr
}

function get_ips (){
 cat $1 | grep -Po "(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}" | head -n $2 | xargs | sed "s/ /,/g"
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
