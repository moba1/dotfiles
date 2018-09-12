#!/usr/bin/env bash

. ./bin/init.bash

export PATH="/usr/local/bin:${PATH}"
export PATH="~/.cargo/bin:${PATH}"

get_linux_dist() {
    dist="unsupported dist"

    if [ -e /etc/debian_version ]
    then
        dist="debian"
    elif type pacman 2>&1 >/dev/null
    then
        dist="arch"
    fi

    echo $dist
}

case "$(uname)" in
    "Darwin")
        ./mitamae local -l debug roles/darwin.rb
        ;;
    "Linux")
        sudo ./mitamae local roles/"$(get_linux_dist)".rb
        ;;
esac

rm "mitamae"

