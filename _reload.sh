#!/usr/bin/env bash

warn "Remove ${bold}${app}${reset}${yellow} as current config link from ${underline}${enabledConfigPath}/${reset}"
rm ${enabledConfigPath}/${app}

warn "Set ${otherColor}${other}${reset}${yellow} as another config link to ${underline}${enabledConfigPath}/${reset}"
ln -s ${availableConfigPath}/${other} ${enabledConfigPath}/${other}

warn "Reloading nginx"
nginx -s reload