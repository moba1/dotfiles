#!/bin/bash

function open() {
  local ext=${1##*.}
  local new_file=$(python3 -c 'import tempfile; print(tempfile.mktemp())').${ext}

  if [ $(uname) = "Darwin" ]; then
    local open_command=/usr/bin/open
  else
    local open_command=xdg-open
  fi

  cp -f $1 $new_file
  $open_command $new_file
}

function main() {
  open $1
}

main $*
