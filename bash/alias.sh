#!/bin/bash

# GIT related
alias g=git
alias gs='git status'
alias glg='git log --oneline --decorate --graph --all'
alias gco='git checkout'
alias gd='git diff'
alias gbr='git branch'
alias gmt='git mergetool'
alias gsu='git diff --name-only --diff-filter=U'
alias gdelbranch='git branch -D'

alias vi=vim

if [ "$(uname)" == "Darwin" ];
then
    alias ls='ls -G -B'
else
    alias ls='ls --color=always -B'
fi

alias ll='ls -l'
alias ld='ls -d'
alias ltr='ls -ltr'

alias histgrep='history | grep'

if [ -e "/proc/sys/kernel/random/uuid" ]
then
    alias uuid='cat /proc/sys/kernel/random/uuid'
else
    alias uuid=/usr/bin/uuidgen
fi

