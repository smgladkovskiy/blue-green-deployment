#!/usr/bin/env bash

# Getting current script path
pushd `dirname $0` > /dev/null
switchPath=`pwd -P`
popd > /dev/null

. ${switchPath}/.env
. ${switchPath}/helpers/colors.sh
. ${switchPath}/helpers/getOptForSwitch.sh

info "Switching to ${bold}${otherColor}${other}${reset}... "
projectPath=${projectsPath}/${project}/${instance}/${other}

if [[ -d ${projectPath} ]]; then
    cd ${projectPath}
else
    error "No such file or directory: ${projectPath}"
    exit 1
fi

warn "Trying to update and restart another instance"
if [[ -f ${projectPath}/restart.sh ]]; then
    . ${projectPath}/restart.sh
else
    error "No such file or directory: ${projectPath}/restart.sh"
    exit 1
fi

. ${switchPath}/actions/nginxSwitchConfig.sh

success "Done!"
info "Project ${bold}${project}${reset} for instance ${bold}${instance}${reset} is on ${otherColor}${other}${reset} point."
info "Try it out!"