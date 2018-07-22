#!/usr/bin/env bash

set -e
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
NAME="ubuntu/install/neofetch.sh"
CYAN="$(tput setaf 6)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
CLR_RESET="$(tput sgr0)"


echo -e "\n----------$CYAN $NAME $CLR_RESET----------"

if sudo apt-get install neofetch -y; then
    echo -e "----------$GREEN Success $CLR_RESET----------\n"
else
    echo -e "----------$REN Failed $CLR_RESET----------\n"
fi
