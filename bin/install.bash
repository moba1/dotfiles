#!/usr/bin/env bash

. ./bin/init.sh

export PATH="/usr/local/bin:${PATH}"
export PATH="~/.cargo/bin:${PATH}"

get_linux_dist() {
    dist="unsupported dist"

    if [ -e /etc/debian_version ]
    then
        dist="debian"
    fi

    echo $dist
}

case "$(uname)" in
    "Darwin")
        ./mitamae local -l debug roles/darwin.rb
        ;;
    "Linux")
        sudo env USER=$USER ./mitamae local roles/"$(get_linux_dist)".rb
        ;;
esac

rm "mitamae"

