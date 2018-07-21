#!/bin/sh

[ -e ~/.bash_profile ] && rm ~/.bash_profile
[ -e /etc/skel/bash_profile ] && cp /etc/skel/bash_profile ~/.bash_profile
[ -e ~/.homebrew ] && rm -Rf ~/.homebrew

