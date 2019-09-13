#!/usr/bin/env bash

SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "$SRC_DIR"/init.bash

export PATH="/usr/local/bin:${PATH}"
export PATH="$HOME/.cargo/bin:${PATH}"

function main() {
  case "$(uname)" in
    "Darwin")
      ./mitamae local roles/darwin.rb
      ;;
    "Linux")
      env username="$USER" sudo -E ./mitamae local roles/linux.rb
      ;;
  esac

  rm -f "mitamae"
}

main

