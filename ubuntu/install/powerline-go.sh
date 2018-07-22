#!/usr/bin/env bash

set -e
INSTALL_LOCATION="$HOME/.local/share/powerline-go"
FULL_PATH="$INSTALL_LOCATION/powerline-go-linux-amd64"
NAME="ubuntu/install/powerline-go.sh"
CYAN="$(tput setaf 6)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
CLR_RESET="$(tput sgr0)"


echo -e "\n----------$CYAN $NAME $CLR_RESET----------"

if [[ -f $FULL_PATH ]]; then
    read -rp "powerline-go already exists. Would you like to overwrite it? (y/n) " answer

    if [[ $answer != "y" ]] && [[ $answer != "Y" ]]; then
        echo -e "----------$RED User Aborted $CLR_RESET----------\n"
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

echo -e "----------$GREEN Success $CLR_RESET----------\n"
