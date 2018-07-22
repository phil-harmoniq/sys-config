#!/usr/bin/env bash

set -e
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
NAME="ubuntu/install/emoji-keyboard.sh"
CYAN="$(tput setaf 6)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
CLR_RESET="$(tput sgr0)"


echo -e "\n----------$CYAN $NAME $CLR_RESET----------"

if ! which pip3 >/dev/null; then
    echo -e "Python3 pip is missing. Using apt-get to install it:\n"
    sudo apt-get install python3-pip -y
fi

echo -e "Installing emoji keyabord using pip3:\n"
sudo pip3 install https://github.com/OzymandiasTheGreat/emoji-keyboard/archive/master.zip

echo -e "----------$GREEN Success $CLR_RESET----------\n"
