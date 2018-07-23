#!/usr/bin/env bash
# Solution from: https://askubuntu.com/questions/906797/scaling-gnome-login-screen-on-hidpi-display

set -e
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
NAME="ubuntu/tweak/login-dpi.sh"
[[ -z $CLR_RESET ]] && source "$SCRIPT_PATH/../import/console-colors.sh"

echo -e "\n----------$CLR_CYAN $NAME $CLR_RESET----------"
echo "Editing the login DPI must be done manualy in an editor and requires sudo access."
echo -e "Find the following lines and edit the scaling default to your desired value:\n"

echo '    <key name="scaling-factor" type="u">'
echo -e '    <default>2</default>\n'

read -rp "Would you like me to open this file in Nano? (y/n)" answer

if [[ $answer != "y" ]] && [[ $answer != "Y" ]]; then
    echo -e "----------$CLR_RED User Aborted $CLR_RESET----------\n"
    exit 1
fi

if sudo nano /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml; then
    echo "Recompiling Glib schemas"
    if ! sudo glib-compile-schemas /usr/share/glib-2.0/schemas; then
        echo -e "----------$CLR_RED Failure Compiling Schemas $CLR_RESET----------\n"
    fi
    echo -e "----------$CLR_YELLOW Success Requires Manual Verification $CLR_RESET----------\n"
else
    echo -e "----------$CLR_RED Failure Opening Glib Schema $CLR_RESET----------\n"
fi
