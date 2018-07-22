#!/usr/bin/env bash

set -e
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
NAME="ubuntu/install/tldr.sh"
CYAN="$(tput setaf 6)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
CLR_RESET="$(tput sgr0)"


echo -e "\n----------$CYAN $NAME $CLR_RESET----------"

echo -e "Installing tldr using apt-get:\n"

if sudo apt-get install tldr -y; then
    echo -e "----------$GREEN Success $CLR_RESET----------\n"
else
    echo -e "----------$RED Failed $CLR_RESET----------\n"
fi
