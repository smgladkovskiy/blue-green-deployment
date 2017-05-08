#!/usr/bin/env bash

# Getting current script path
pushd `dirname $0` > /dev/null
switchPath=`pwd -P`
popd > /dev/null


. ${switchPath}/.env
. ${switchPath}/helpers/colors.sh
. ${switchPath}/helpers/getOptForSwitch.sh


warn "Migrating database"
. "${projectPath}/migrate.sh"

success "Done!"