#!/bin/sh

rm -Rf ~/.homebrew ~/.cargo/bin ~/.tex

[ -e ~/.bash_profile ] && rm ~/.bash_profile
[ -e /etc/skel/bash_profile ] && cp /etc/skel/bash_profile ~/.bash_profile
