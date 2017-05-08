#!/usr/bin/env bash

docker-compose down --rmi local --remove-orphans
docker-compose pull --parallel
docker-compose up -d

echo "System updated successfully"