#!/bin/sh

[ -e ~/.bash_profile ] && rm ~/.bash_profile
[ -e /etc/skel/bash_profile ] && cp /etc/skel/bash_profile ~/.bash_profile

targets="
    .homebrew
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

