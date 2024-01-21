#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $DIR
cd ..

if [ -z "$CF_API_EMAIL" ]; then
    echo "CF_API_EMAIL is not set."
    exit 1
fi

if [ -z "$CF_API_KEY" ]; then
    echo "CF_API_KEY is not set."
    exit 1
fi

if [ -z "$PRIVATE_IP" ]; then
    echo "PRIVATE_IP is not set."
    exit 1
fi

echo "Creating traefik network..."
docker network create traefik -d bridge

echo "Creating traefik container..."
docker compose up -d

# healthcheck
echo "Healthcheck Traefik... (20 seconds)"
sleep 20

health_status=$(docker inspect --format='{{.State.Health.Status}}' traefik)

if [ "$health_status" != "healthy" ]; then
  echo "Traefik is not healthy. Status: $health_status"
fi

echo "Traefik has been successfully installed."
