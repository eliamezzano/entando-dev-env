#!/bin/sh

echo ${1}
docker-compose stop ${1}
echo 'y' | docker-compose rm ${1}
docker-compose up --force-recreate --no-deps -d --build ${1}