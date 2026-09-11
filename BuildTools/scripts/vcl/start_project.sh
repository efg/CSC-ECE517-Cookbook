#!/bin/bash

scriptDir=$(dirname "$0")

envfile='./BuildTools/.env'
if ! [ -f $envfile ]; then
  cp $scriptDir/../../example.env $scriptDir/../../$envfile
fi

sudo docker compose -f $scriptDir/../../docker-compose.yml \
  up --build --remove-orphans -d
