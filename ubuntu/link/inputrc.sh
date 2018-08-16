#!/usr/bin/env bash

set -e
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
NAME="ubuntu/tweak/bash-case-insensitive.sh"
INPUTRC_LOCATION="$SCRIPT_PATH/../.inputrc"
[[ -z $CLR_RESET ]] && source "$SCRIPT_PATH/../import/console-colors.sh"


echo -e "\n----------$CLR_CYAN $NAME $CLR_RESET----------"

if [[ -f ~/.inputrc ]]; then
    read -rp "~/.inputrc already exists. Would you like to overwrite it? (y/n) " answer

    if [[ $answer != "y" ]] && [[ $answer != "Y" ]]; then
        echo -e "----------$CLR_RED User Aborted $CLR_RESET----------\n"
        exit 1
    fi

    rm ~/.inputrc
fi

echo "Creating ~/.inputrc symlink"
ln -s "$INPUTRC_LOCATION" ~

echo -e "----------$CLR_GREEN Success $CLR_RESET----------\n"
