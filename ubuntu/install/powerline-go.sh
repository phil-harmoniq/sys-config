#!/usr/bin/env bash

set -e
INSTALL_LOCATION="$HOME/.local/share/powerline-go"
FULL_PATH="$INSTALL_LOCATION/powerline-go-linux-amd64"
NAME="ubuntu/install/powerline-go.sh"
[[ -z $CLR_RESET ]] && source "$SCRIPT_PATH/../import/console-colors.sh"


echo -e "\n----------$CLR_CYAN $NAME $CLR_RESET----------"

if [[ -f $FULL_PATH ]]; then
    read -rp "powerline-go already exists. Would you like to overwrite it? (y/n) " answer

    if [[ $answer != "y" ]] && [[ $answer != "Y" ]]; then
        echo -e "----------$CLR_RED User Aborted $CLR_RESET----------\n"
        exit 1
    fi
fi

if [[ ! -d $INSTALL_LOCATION ]]; then
    echo "$INSTALL_LOCATION doesn't exist. Creating the directory."
    mkdir "$INSTALL_LOCATION"
fi

echo "Downloading powerline-go v1.11 to $INSTALL_LOCATION"
wget "https://github.com/justjanne/powerline-go/releases/download/v1.11.0/powerline-go-linux-amd64" -O "$FULL_PATH" -q --show-progress

echo "Setting as executable"
chmod +x "$INSTALL_LOCATION/powerline-go-linux-amd64"

if ! fc-list | grep -i "PowerlineSymbols" >/dev/null; then
    echo -e "Ubuntu powerline font is missing. Using apt-get to install it:\n"
    sudo apt-get install fonts-powerline
fi

echo -e "----------$CLR_GREEN Success $CLR_RESET----------\n"
