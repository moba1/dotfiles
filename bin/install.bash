#!/usr/bin/env bash

. ./bin/init.bash

export PATH="/usr/local/bin:${PATH}"
export PATH="~/.cargo/bin:${PATH}"

function main() {
  case "$(uname)" in
    "Darwin")
      ./mitamae local -l debug roles/darwin.rb
      ;;
    "Linux")
      env username=$USER sudo -E ./mitamae local roles/linux.rb
      ;;
  esac

  rm -f "mitamae"
}

main

