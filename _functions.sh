#!/usr/bin/env bash

# Colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 33`
bold=`tput bold`
underline=`tput smul`
reset=`tput sgr0`
resetUnderline=`tput rmul`

function info {
    echo $1
}

function warn {
    echo "${yellow}${1}${reset}"
}

function success {
    echo "${green}${1}${reset}"
}

function error {
    echo "${red}${1}${reset}"
}

function prim {
    echo "${blue}${1}${reset}"
}