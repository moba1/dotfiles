#!/usr/bin/env bash

SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "$SRC_DIR"/init.bash

export PATH="/usr/local/bin:${PATH}"
export PATH="$HOME/.cargo/bin:${PATH}"

function usage() {
  local prog_name
  prog_name=$(basename "$0")
  cat << EOF
  setup dotfiles

  Usage:
    $prog_name [-h | --help]
    $prog_name [-g | --gui]

  Option:
    -h, --help    show this help message
    -g, --gui     setup with GUI
EOF
}

function main() {
  local gui="off"

  while getopts "gh-:" OPT
  do
    if [ $OPT = "-" ]; then
      OPT=$(echo $OPTARG | awk -F'=' '{print $1}')
      OPTARG=$(echo $OPTARG | awk -F'=' '{print $2}')
    fi

    case "$OPT" in
      h|help) usage; exit;;
      g|gui) gui="on";;
      ?) usage; exit 1;;
      *) printf "invalid option -- %s" $OPT; exit 1;;
    esac
  done

  case "$(uname)" in
    "Darwin")
      ./mitamae local roles/darwin.rb
      ;;
    "Linux")
      env username="$USER" gui="$gui" sudo -E ./mitamae local roles/linux.rb
      ;;
  esac

  rm -f "mitamae"
}

main "$@"

