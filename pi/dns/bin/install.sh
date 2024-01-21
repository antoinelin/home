#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $DIR
cd ..

if [ -z "$PRIVATE_IP" ]; then
    echo "PRIVATE_IP is not set."
    exit 1
fi

CONF_FILE="/etc/resolv.conf"
CONF_FILE_BACKUP="/etc/resolv.conf.backup"

# Make a backup of the original file
sudo cp $CONF_FILE $CONF_FILE_BACKUP

sudo echo "nameserver $PRIVATE_IP" | sudo tee -a $CONF_FILE

# healthcheck
echo "Healthcheck DNS server... (5 seconds)"
sleep 5

DNS_RECORD_TEST="pi.home.sidevision.io"

if host "$DNS_RECORD_TEST" > /dev/null; then
    echo "DNS server have been successfully installed."
else
    echo "DNS resolution failed for $DNS_RECORD_TEST."
    exit 1
fi

echo "DNS nameservers has been successfully updated. DNS server is ready to use."
