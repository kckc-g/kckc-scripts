#!/bin/bash

export LS_COLORS='no=00:fi=00:di=01;33:ln=01;36:pi=40;33:so=01;35db=40;33;01:cd=40;33;01:or=101;93;01:ex=01;32'
export LSCOLORS='Dxgxxxxxcxxxxxxxxxxxxx'

# vim mode in cmd editiing
set -o vi

# default file permission
umask 022

export PS1="[\u@\h \W]: "

# for putty set TERM to 256 colors
if [ "$TERM" = xterm ]; then TERM=xterm-256color; fi
