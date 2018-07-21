#!/bin/sh

. ./bin/init.sh

export PATH="~/.homebrew/bin:${PATH}"
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
        ./mitamae local roles/darwin.rb
        ;;
    "linux")
        sudo ./mitamae local roles/"$(get_linux_dist)".rb
        ;;
esac

rm "mitamae"

