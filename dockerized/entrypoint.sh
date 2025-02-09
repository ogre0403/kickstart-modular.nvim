#!/bin/bash

source /root/.nvm/nvm.sh
export LANG=en_US.UTF-8

tmux new-session nvim $1
