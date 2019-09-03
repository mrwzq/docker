#!/bin/bash

. ./config.sh
source ./config.sh

params=""
params="${params} -p ${SERVER_PORT}:80"
params="${params} -p ${SERVER_HTTPS_PORT}:443"
params="${params} -p ${SUPERVISOR_PORT}:8999"
params="${params} --privileged=true"
params="${params} --ulimit core=0"
params="${params} --restart=always"
params="${params} -v ${PROJECT_PATH}:/webroot"
params="${params} -v ${CERT_PATH}:/cert"
params="${params} --name ${PROJECT_NAME}_${VERSION}"

container_id=`docker ps -a --filter ancestor=${REPOSITORY}:${TAG} --format "{{.ID}}"`
if [ "$container_id" != "" ]; then
    echo "Stopping ${PROJECT_NAME}_${VERSION} container..."
    docker rm -f ${container_id} >> /dev/null
fi


echo "Starting ${PROJECT_NAME}_${VERSION} container..."
docker run -d ${params} ${REPOSITORY}:${TAG}

run_id=`docker ps --filter ancestor=${REPOSITORY}:${TAG} --format "{{.ID}}"`
if [ "${run_id}" == "" ]; then
    echo "Error: Start container failed!"
    exit 1
fi

echo .
sleep 1

echo "Start ${PROJECT_NAME}_${VERSION}  successed!"