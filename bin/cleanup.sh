#!/bin/sh

rm -Rf ~/.homebrew ~/.cargo/bin

if [ -e /etc/skel/bash_profile ]
then
    cp /etc/skel/bash_profile ~/.bash_profile
else
    rm ~/.bash_profile
fi
