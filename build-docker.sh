#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Usage: ./build-docker.sh def_file_name version_number"
    exit 1
fi

if [[ -z "$2" ]]; then
    echo "Usage: ./build-docker.sh def_file_name version_number"
    exit 1
fi

echo "Starting build..."
cp "$1" ./prosody.deb
docker build -t justinba1010/docker-prosody:"$2" .
for i in "${@:3}"; do
  echo "Also building tag $i"
  docker build -t justinba1010/docker-prosody:"$i" .
done
docker push justinba1010/docker-prosody

echo "Cleaning up..."
docker rmi justinba1010/docker-prosody:"$2"
for i in "${@:3}"; do
  echo "Also cleaning tag $i"  
  docker rmi justinba1010/docker-prosody:"$i"
done
