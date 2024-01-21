#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $DIR
cd ..

if [ -z "$PRIVATE_IP" ]; then
    echo "PRIVATE_IP is not set."
    exit 1
fi

sudo chown root:root ./cache ./logs ./records

docker compose up -d

# healthcheck
echo "Healthcheck DNS metrics exporter... (5 seconds))"
sleep 5
wget --no-verbose --tries=1 --spider http://$PRIVATE_IP:9119/ready || exit 1

echo "DNS server and metrics exporter have been installed."
