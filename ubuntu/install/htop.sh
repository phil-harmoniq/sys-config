#!/usr/bin/env bash

set -e
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
NAME="ubuntu/install/htop.sh"
if [[ -z $CLR_RESET ]]; then source "$SCRIPT_PATH/../import/console-colors.sh"; fi


echo -e "\n----------$CLR_CYAN $NAME $CLR_RESET----------"

if sudo apt-get install htop -y; then
    echo -e "----------$CLR_GREEN Success $CLR_RESET----------\n"
else
    echo -e "----------$CLR_RED Failed $CLR_RESET----------\n"
fi
