#!/bin/bash

function open() {
  local file=${1%.*}
  local ext=${1##*.}
  local new_file=${file}-copy.${ext}

  if [ $(uname) = "Darwin" ]; then
    local open_command=/usr/bin/open
  else
    local open_command=xdg-open
  fi

  cp $1 $new_file
  $open_command $new_file
}

function main() {
  open $1
}

main $*
