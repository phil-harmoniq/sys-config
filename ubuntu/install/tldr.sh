#!/usr/bin/env bash

set -e
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
NAME="ubuntu/install/tldr.sh"
[[ -z $CLR_RESET ]] && source "$SCRIPT_PATH/../import/console-colors.sh"


echo -e "\n----------$CLR_CYAN $NAME $CLR_RESET----------"

echo -e "Installing tldr using apt-get:\n"

if sudo apt-get install tldr -y; then
    echo -e "----------$CLR_GREEN Success $CLR_RESET----------\n"
else
    echo -e "----------$CLR_RED Failed $CLR_RESET----------\n"
fi
