#!/usr/bin/env bash

set -e
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
NAME="ubuntu/link/bash_aliases.sh"
ALIASES_LOCATION="$SCRIPT_PATH/../.bash_aliases"
[[ -z $CLR_RESET ]] && source "$SCRIPT_PATH/../import/console-colors.sh"


echo -e "\n----------$CLR_CYAN $NAME $CLR_RESET----------"

if [[ ! -f $ALIASES_LOCATION ]]; then
    echo "ubuntu/.bash_aliases is missing. Has something been moved?"
    echo -e "----------$CLR_RED Failed $CLR_RESET----------\n"
    exit 1
fi

if [[ -f ~/.bash_aliases ]]; then
    read -rp "~/.bash_aliases already exists. Would you like to overwrite it? (y/n) " answer

    if [[ $answer != "y" ]] && [[ $answer != "Y" ]]; then
        echo -e "----------$CLR_RED User Aborted $CLR_RESET----------\n"
        exit 1
    fi

    rm ~/.bash_aliases
fi

echo "Creating ~/.bash_aliases symlink"
ln -s "$ALIASES_LOCATION" ~

echo -e "----------$CLR_GREEN Success $CLR_RESET----------\n"
