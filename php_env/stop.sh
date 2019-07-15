#!/bin/bash

. ./config.sh
source ./config.sh

container_id=`docker ps -a --filter ancestor=${REPOSITORY}:${TAG} --format "{{.ID}}"`
if [ "$container_id" != "" ]; then
    echo "Stopping ${PROJECT_NAME}_${VERSION} container..."
    docker rm -f ${container_id} >> /dev/null
fi

if [ "$container_id" == "" ]; then
    echo "${PROJECT_NAME}_${VERSION} is not running..."
fi