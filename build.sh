#!/bin/bash

IMAGE="fopina/tor-sshd"
VERSION="1"

cd $(dirname $0)

docker build -t $IMAGE:$VERSION .
docker push $IMAGE:$VERSION