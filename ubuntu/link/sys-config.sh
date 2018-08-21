#!/usr/bin/env bash

set -e
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
CONFIG_PATH="$( cd "$(dirname "$SCRIPT_PATH/../../")" ; pwd -P )"
echo "$CONFIG_PATH"
NAME="ubuntu/link/sys-config.sh"
[[ -z $CLR_RESET ]] && source "$SCRIPT_PATH/../import/console-colors.sh"


echo -e "\n----------$CLR_CYAN $NAME $CLR_RESET----------"

if [[ -L ~/.sys-config ]]; then
    read -rp "The ~/.sys-config symlink already exists. Would you like to overwrite it? (y/n) " answer

    if [[ $answer != "y" ]] && [[ $answer != "Y" ]]; then
        echo -e "----------$CLR_RED User Aborted $CLR_RESET----------\n"
        exit 1
    fi

    rm ~/.sys-config
fi

echo "Creating ~/.sys-config symlink"
ln -s "$CONFIG_PATH" ~/.sys-config

echo -e "----------$CLR_GREEN Success $CLR_RESET----------\n"
