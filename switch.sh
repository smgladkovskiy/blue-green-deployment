#!/usr/bin/env bash

# Getting current script path
pushd `dirname $0` > /dev/null
switchPath=`pwd -P`
popd > /dev/null

. "${switchPath}/_functions.sh"
. "${switchPath}/_getopt.sh"

info "Switching to ${bold}${otherColor}${other}${reset}... "
projectPath=/opt/projects/${project}/${instance}/${other}
cd ${projectPath}

warn "Updating and restarting another instance"
. "${projectPath}/restart.sh"

. "${switchPath}/_reload.sh"

success "Done!"
info "Project ${bold}${project}${reset} for instance ${bold}${instance}${reset} is on ${otherColor}${other}${reset} point."
info "Try it out!"