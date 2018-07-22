#!/usr/bin/env bash

set -e
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"


echo "adding "
sudo add-apt-repository -u ppa:snwh/ppa
