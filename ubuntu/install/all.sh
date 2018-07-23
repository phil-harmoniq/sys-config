#!/usr/bin/env bash

set -e
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
NAME="ubuntu/install/all.sh"
[[ -z $CLR_RESET ]] && source "$SCRIPT_PATH/../import/console-colors.sh"


echo -e "\n----------$CLR_CYAN$CLR_BOLD $NAME $CLR_RESET----------"

if ! "$SCRIPT_PATH/neofetch.sh";then say_fail; fi
if ! "$SCRIPT_PATH/powerline-go.sh";then say_fail; fi
if ! "$SCRIPT_PATH/tldr.sh";then say_fail; fi
if ! "$SCRIPT_PATH/emoji-keyboard.sh";then say_fail; fi

echo -e "----------$CLR_GREEN$CLR_BOLD Success $CLR_RESET----------\n"

say_fail()
{
    echo -e "----------$CLR_RED$CLR_BOLD Failed $CLR_RESET----------\n"
}
