#!/usr/bin/env bash

OPTS=`getopt -o hp:i: --long help,project:,instance: -n 'parse-options' -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

#echo "$OPTS"
eval set -- "$OPTS"

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

availableConfigPath=/etc/nginx/sites-available/${project}/${instance}
enabledConfigPath=/etc/nginx/sites-enabled/${project}/${instance}

if [ ! -d ${enabledConfigPath} ]
then
    echo "There is no settled config in ${enabledConfigPath}"
    exit 1;
fi

app=$(basename ${enabledConfigPath}/*)

# Investigate instance
if [ ${app} == 'green' ]
then
  other='blue'
else
  other='green'
fi

projectPath=/opt/projects/${project}/${instance}/${other}

cd ${projectPath}
# Updating another instance
${projectPath}/restart.sh

# Current instance config remove
rm ${enabledConfigPath}/${app}

# Other instance config link set
ln -s ${availableConfigPath}/${other} ${enabledConfigPath}/${other}

# nginx reload
exec nginx -s reload