#!/bin/sh

. ./bin/init.sh

export PATH="~/.homebrew/bin:${PATH}"
export PATH="~/.cargo/bin:${PATH}"

case "$(uname)" in
    "Darwin")
        ./mitamae local roles/darwin.rb
        ;;
esac

rm "mitamae"