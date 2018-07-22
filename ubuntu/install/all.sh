#!/usr/bin/env bash

set -e
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
NAME="ubuntu/install/all.sh"
CYAN="$(tput setaf 6)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BOLD="$(tput bold)"
CLR_RESET="$(tput sgr0)"


echo -e "\n----------$CYAN$BOLD $NAME $CLR_RESET----------"

if ! "$SCRIPT_PATH/neofetch.sh";then say_fail; fi
if ! "$SCRIPT_PATH/powerline-go.sh";then say_fail; fi
if ! "$SCRIPT_PATH/tldr.sh";then say_fail; fi
if ! "$SCRIPT_PATH/emoji-keyboard.sh";then say_fail; fi

echo -e "----------$GREEN$BOLD Success $CLR_RESET----------\n"

say_fail()
{
    echo -e "----------$RED$BOLD Failed $CLR_RESET----------\n"
}
