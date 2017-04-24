#!/usr/bin/env bash

# Parse cli options
OPTS=`getopt -o hp:i: --long help,project:,instance: -n 'parse-options' -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

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
    echo 'Project and instance options are mandatory to enter!'
    exit 1;
fi

switchPath=$(pwd)
availableConfigPath=/etc/nginx/sites-available/${project}/${instance}
enabledConfigPath=/etc/nginx/sites-enabled/${project}/${instance}

if [ ! -d ${enabledConfigPath} ]
then
    echo "There is no settled config in ${enabledConfigPath}"
    exit 1;
fi

app=$(basename ${enabledConfigPath}/*)

echo "Project ${project} for instance ${instance} is on ${app} point."

# Investigate instance
if [ ${app} == 'green' ]
then
  other='blue'
else
  other='green'
fi