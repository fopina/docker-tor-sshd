#!/bin/bash

IMAGE="x"
VERSION="1"

cd $(dirname $0)

docker build -t $IMAGE:$VERSION .