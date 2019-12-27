#!/bin/bash

export BASE_DIR=$(dirname $BASH_SOURCE)
export BASE_DIR=$(realpath $BASE_DIR)

ln -s $BASE_DIR/.vim $BASE_DIR/.vimrc ~


