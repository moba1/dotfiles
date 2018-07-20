#!/bin/sh

set -ex

mitamae_version="1.6.2"
case "$(uname)" in
    "Linux")
        mitamae_platform="mitamae-x86_64-linux"
        ;;
    "Darwin")
        mitamae_platform="mitamae-x86_64-darwin"
        ;;
    *)
        echo "unsupported platform: $(uname)" >&2
        exit 1
        ;;
esac

source_url="https://github.com/k0kubun/mitamae/releases/download/v${mitamae_version}/${mitamae_platform}.tar.gz"
tmp="/tmp/${mitamae_platform}.tar.gz"
if which wget &> /dev/null
then
    wget -O "${tmp}" -q "${source_url}"
elif which curl &>/dev/null
then
    curl -L "${source_url}" -o "${tmp}"
else
    echo "install wget or curl" >&2
    exit 1
fi

tar xzvf "${tmp}"
rm -f "${tmp}"
chmod +x "${mitamae_platform}"
mv "${mitamae_platform}" "mitamae"
