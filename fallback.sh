#!/usr/bin/env bash

# Getting current script path
pushd `dirname $0` > /dev/null
switchPath=`pwd -P`
popd > /dev/null

. "${switchPath}/_functions.sh"
. "${switchPath}/_getopt.sh"

. "${switchPath}/_reload.sh"