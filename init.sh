#!/usr/bin/env bash
project=$1

# Инициализация структуры проекта
mkdir -p /opt/projects/${project}/{stage,test}/{green,blue}
mkdir -p /etc/nginx/{sites-enabled,sites-available}/${project}/{stage,test}