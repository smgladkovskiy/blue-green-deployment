#!/usr/bin/env bash

# Parse cli options
OPTS=`getopt -o hp:i: --long help,project:,instance: -n 'parse-options' -- "$@"`
if [ $? != 0 ] ; then error "Failed parsing options." >&2 ; exit 1 ; fi

eval set -- "${OPTS}"

while true; do
  case "$1" in
    -h | --help )     HELP=true; shift ;;
    -p | --project )  project="$2"; shift; shift ;;
    -i | --instance ) instance="$2"; shift; shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if [[ ${project} == '' || ${instance} == '' ]]
then
    error 'Project and instance options are mandatory to enter!'
    exit 1;
fi

availableConfigPath=${nginxAvailableConfigs}/${project}/${instance}
enabledConfigPath=${nginxEnabledConfigs}/${project}/${instance}

if [ ! -d ${enabledConfigPath} ]
then
    error "There is no settled config in ${underline}${enabledConfigPath}${reset}"
    exit 1;
fi

app=$(basename ${enabledConfigPath}/*)

# Investigate instance
if [ ${app} == 'green' ]
then
  other='blue'
  otherColor=${blue}
  appColor=${green}
else
  other='green'
  otherColor=${green}
  appColor=${blue}
fi

info "Project ${bold}${project}${reset}${yellow} for instance ${bold}${instance}${reset}${yellow} is on ${bold}${appColor}${app}${reset}${yellow} point."