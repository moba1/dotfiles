#!/bin/sh

. ./bin/init.sh

export PATH="~/.homebrew/bin:${PATH}"
export PATH="~/.cargo/bin:${PATH}"

rm -Rf /tmp/install-tl*

case "$(uname)" in
    "Darwin")
        ./mitamae local roles/darwin.rb
        ;;
esac

rm "mitamae"