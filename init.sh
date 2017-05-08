#!/usr/bin/env bash

. ./helpers/colors.sh
. ./helpers/filesAndFolderActions.sh

success "Start environment initialization..."

# ENV files init
envFile='.env'
usedPortsFile='.used-ports'
fileFromExample ${envFile}
fileFromExample ${usedPortsFile}

. ./.env

success "Parsing CLI options"
OPTS=`getopt -o p:h:r: --long project:,project-host-base:,repo: -n 'parse-options' -- "$@"`
if [ $? != 0 ] ; then error "Failed parsing options." >&2 ; exit 1 ; fi

eval set -- "${OPTS}"

while true; do
  case "$1" in
    --help )          HELP=true; shift ;;
    -p | --project )  project="$2"; shift; shift ;;
    -h | --project-host-base )  projectHostBase="$2"; shift; shift ;;
    -r | --repo )     repo="$2"; shift; shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

success "Creating project structure:"
info "Project: ${project}"
info "Host Base: *.${projectHostBase}"
info "Git repo for docker-env: ${repo}"

if [[ ${project} == '' || ${projectHostBase} == '' || ${repo} == '' ]]
then
    error 'Project, repo and project-host options are mandatory to enter!'
    exit 1;
fi

# Check git clone ability
if [[ ! ($(git ls-remote ${repo})) ]]; then
    error 'There is no access to clone doker-compose repo for project!'
    exit 1;
    # Put Failure actions here...
else
    rm -rf tmp
    # Put Success actions here...
fi

# Project structure initialization
logsPath=${projectsPath}/${project}/logs
mkdir -p ${logsPath}
success "Project logs path '${logsPath}' is created"

stages=( 'stage' 'test' )
instances=( 'green' 'blue' )
lastUsedPort=$(tail -1 "${usedPortsFile}")
let "nextPort = ${lastUsedPort} - (${lastUsedPort} - 8000)/10"

for stage in "${stages[@]}"
do
    nginxStagePathEnabled=${nginxEnabledConfigs}/${project}/${stage}
    nginxStagePathAvailable=${nginxAvailableConfigs}/${project}/${stage}

    mkdir -p ${nginxStagePathAvailable}
    success "Nginx available configs path '${nginxStagePathAvailable}' created"

    mkdir -p ${nginxStagePathEnabled}
    success "Nginx enabled config path '${nginxStagePathEnabled}' created"

    let "nextPort += 10"

    for instance in "${instances[@]}"
    do

        let "nextPort += 1"
        echo ${nextPort} >> ${usedPortsFile}

        projectInstancePath=${projectsPath}/${project}/${stage}/${instance}
        if [[ ! -d ${projectInstancePath} ]]; then
            mkdir -p ${projectInstancePath}
            success "Project instance path '${projectInstancePath}' is created"
        fi

        nginxConfig=${nginxStagePathAvailable}/${instance}
        cp ./templates/nginx.conf ${nginxConfig}
        sed -i "s,NAME,${project},g" ${nginxConfig}
        sed -i "s,STAGE,${stage},g" ${nginxConfig}
        sed -i "s,INSTANCE_PORT,${nextPort},g" ${nginxConfig}
        sed -i "s,INSTANCE,${instance},g" ${nginxConfig}
        sed -i "s,HOST,${stage}.${projectHostBase},g" ${nginxConfig}
        sed -i "s,LOGS_PATH,${logsPath},g" ${nginxConfig}
        success "Nginx config '${nginxConfig}' is created"

        git clone -q ${repo} ${projectInstancePath}
        cp ${projectInstancePath}/.env.example ${projectInstancePath}/.env
        sed -i "s,NGINX_HTTP_PORT=80,NGINX_HTTP_PORT=${nextPort},g" ${projectInstancePath}/.env
        sed -i "s,INSTANCE=develop,INSTANCE=${instance},g" ${projectInstancePath}/.env
    done
done

success "Job is done!"