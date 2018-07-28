#!/usr/bin/env bash

[ -e ~/.bash_profile ] && rm ~/.bash_profile
[ -e /etc/skel/bash_profile ] && cp /etc/skel/bash_profile ~/.bash_profile

targets="
    .local
    .xonshrc
    .multirust
    .rustup
    .cargo
"
for target in $targets
do
    target_path=${HOME}/${target}
    [ -e ${target_path} ] && rm -rf ${target_path}
done

if [ $(uname) = "Darwin" ]
then
    echo | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
fi
rm -f /usr/local/bin/brew

