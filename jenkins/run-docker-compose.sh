#!/bin/sh

export BUILD_DATE=$(date -u +'%Y-%m-%dT%H-%M-%SZ')
echo ">>> Using BUILD_DATE=${BUILD_DATE}"

docker compose build --build-arg BUILD_DATE="${BUILD_DATE}"
docker compose up -d