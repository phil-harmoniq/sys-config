#!/usr/bin/env bash

set -e
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
NAME="ubuntu/install/add-local-bin.sh"
[[ -z $CLR_RESET ]] && source "$SCRIPT_PATH/../import/console-colors.sh"


echo -e "\n----------$CLR_CYAN $NAME $CLR_RESET----------"
echo "Attempting to create ~/.local/bin"

if [[ -d ~/.local/bin ]]; then
    echo -e "----------$CLR_YELLOW Directory Already Exists $CLR_RESET----------\n"
else
    if mkdir -p ~/.local/bin; then
        echo -e "----------$CLR_GREEN Success $CLR_RESET----------\n"
    else
        echo -e "----------$CLR_GREEN Unable to create ~/.local/bin $CLR_RESET----------\n"
    fi
fi
