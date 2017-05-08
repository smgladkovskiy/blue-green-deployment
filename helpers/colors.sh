#!/usr/bin/env bash

# Colors
red="\e[91m"
green="\e[92m"
yellow="\e[93m"
blue="\e[34m"
bold="\e[1m"
underline="\e[4m"
reset="\e[0m"
resetUnderline="\e[24m"

## COLOR FUNCTIONS
function warn {
    echo -e "${yellow}${1}${reset}"
}

function success {
    echo -e "${green}${1}${reset}"
}

function error {
    echo -e "${red}${1}${reset}"
}

function info {
    echo -e "${blue}${1}${reset}"
}