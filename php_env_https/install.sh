#!/bin/bash

. ./config.sh
source ./config.sh

docker build -t ${REPOSITORY}:${TAG} .

echo "Install ${PROJECT_NAME}_${VERSION}  successed!"