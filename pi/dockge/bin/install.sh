#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $DIR
cd ..

echo "Creating Dockge container..."
docker compose up -d
