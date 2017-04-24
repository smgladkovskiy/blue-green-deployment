#!/usr/bin/env bash

# Getting current script path
pushd `dirname $0` > /dev/null
switchPath=`pwd -P`
popd > /dev/null

. "${switchPath}/_getopt.sh"

echo "Switching to ${other}... "
projectPath=/opt/projects/${project}/${instance}/${other}
cd ${projectPath}

echo "Updating and restarting another instance"
. "${projectPath}/restart.sh"

. "${switchPath}/_reload.sh"

echo "Done!"
echo "Project ${project} for instance ${instance} is on ${other} point."
echo "Try it out!"