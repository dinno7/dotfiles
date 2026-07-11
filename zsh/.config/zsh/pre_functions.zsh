#! /usr/bin/env bash

# INFO: The funcitons which load first of all to use in pre loading

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

function cmd_exists() {
  command -v "$1" >/dev/null 2>&1
}

capitalize_word() {
  word="${1?Please pass the word in first argument}"
  firstCharUpper="$(echo "${word:0:1}" | tr '[:lower:]' '[:upper:]')"
  echo "$firstCharUpper${word:1}"
}
