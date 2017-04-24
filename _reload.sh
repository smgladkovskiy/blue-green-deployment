#!/usr/bin/env bash

echo "Remove ${app} as current config link from ${enabledConfigPath}/"
rm ${enabledConfigPath}/${app}

echo "Set ${other} as another config link to ${enabledConfigPath}/"
ln -s ${availableConfigPath}/${other} ${enabledConfigPath}/${other}

echo "Reloading nginx"
nginx -s reload