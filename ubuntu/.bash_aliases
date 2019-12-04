#!/usr/bin/env bash
# ~/.bash_aliases is sourced by ~/.bashrc

# Colors from askubuntu.com
CLR_RESET=$(tput sgr0)
CLR_BOLD=$(tput bold)
CLR_BLACK=$(tput setaf 0)
CLR_RED=$(tput setaf 1)
CLR_GREEN=$(tput setaf 2)
CLR_YELLOW=$(tput setaf 3)
CLR_BLUE=$(tput setaf 4)
CLR_MAGENTA=$(tput setaf 5)
CLR_CYAN=$(tput setaf 6)
CLR_WHITE=$(tput setaf 7)
USER_COLOR=$CLR_BLUE

# User Prompt Style. Use powerline-go if installed, otherwise use ANSI prompt
if [[ -f ~/.local/share/powerline-go/powerline-go-linux-amd64 ]] && [[ "$TERM" != "linux" ]]; then
    mods="docker,venv,user,host,ssh,cwd,perms,hg,jobs,exit,root"
    function _update_ps1_powerline() {
        PS1="$(~/.local/share/powerline-go/powerline-go-linux-amd64 -modules $mods -colorize-hostname -error $?)"
    }
    PROMPT_COMMAND="_update_ps1_powerline; $PROMPT_COMMAND"
else
    function _update_ps1_custom() {
        if [[ $? == 0 ]]; then
            PS1="\[$CLR_RESET\]\[$CLR_CYAN\][ \[$CLR_BOLD\]\[$USER_COLOR\]\u@\h\[$CLR_RESET\]\[$CLR_GREEN\] \w\[$CLR_CYAN\] ]\[$CLR_RESET\]\\$ "
        else
            PS1="\[$CLR_RESET\]\[$CLR_RED\][ \[$CLR_BOLD\]\u@\h\[$CLR_RESET\]\[$CLR_GREEN\] \w\[$CLR_RED\] ]\[$CLR_RESET\]\\$ "
        fi
    }
    PROMPT_COMMAND="_update_ps1_custom; $PROMPT_COMMAND"
fi

# Custom Aliases
alias ll='ls -lhF --color=auto'
alias la='ls -lhaF --color=auto'
alias sys-update='sudo apt update && sudo apt upgrade -y'
alias clear-crash-log='sudo rm /var/crash/*'

# Ubuntu doesn't source ~/.local/bin but it's recommended to install user programs there
[[ -d ~/.local/bin ]] && PATH="$HOME/.local/bin:$PATH"

# You may want to store any private environment variables in a seperate file
if [[ -d ~/.local/lib ]] && [[ -z $LD_LIBRARY_PATH ]]; then
    export LD_LIBRARY_PATH="$HOME/.local/lib"
elif [[ -d ~/.local/lib ]] && ! [[ -z $LD_LIBRARY_PATH ]]; then
    LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.local/lib"
fi

# You may want to store any private environment variables in a seperate file
[[ -f ~/.private_keys ]] && . ~/.private_keys

if which neofetch >/dev/null; then neofetch; fi
