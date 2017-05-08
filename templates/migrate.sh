#!/usr/bin/env bash

. ./.env

docker exec -t ${COMPOSE_PROJECT_NAME/-/}_web_1 php artisan migrate --force --no-interaction