#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $DIR
cd ..

if [ -z "$TZ" ]; then
    echo "TZ is not set."
    exit 1
fi

if [ -z "$DEVICE_ID" ]; then
    echo "DEVICE_ID is not set."
    exit 1
fi

if [ -z "$PORT" ]; then
    echo "PORT is not set."
    exit 1
fi

echo "Creating z2m container..."
docker compose up -d

# healthcheck
echo "Healthcheck Z2M... (20 seconds)"
sleep 5

health_status=$(docker inspect --format='{{.State.Health.Status}}' z2m)

if [ "$health_status" != "healthy" ]; then
  echo "Z2M is not healthy. Status: $health_status"
else
  echo "Z2M has been successfully installed."
fi

