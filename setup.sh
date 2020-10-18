#!/bin/bash

export BASE_DIR=$(dirname $BASH_SOURCE)
export BASE_DIR=$(realpath $BASE_DIR)

# Bash Script Setup
BASHRC=${1:-~/.bashrc}
            
echo "" >> ${BASHRC}

for f in `/bin/ls -1 ${BASE_DIR}/bash/*.sh`
do
    echo ". ${BASE_DIR}/bash/$(basename $f)" >> ${BASHRC}
done
           
echo "" >> ${BASHRC}


# SETUP vim
ln -s $BASE_DIR/vim ~/.vim
ln -s $BASE_DIR/vim/vimrc ~/.vimrc


# github config
git config --global user.email "kckc.g4@gmail.com"
git config --global user.name kckc-g
git config --global credential.helper cache

#git clone https://github.com/kckc-g/hguo-lib.git
#git clone https://github.com/kckc-g/kckc-scripts.git
