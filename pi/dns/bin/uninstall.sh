#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $DIR
cd ..

CONF_FILE="/etc/resolv.conf"
CONF_FILE_BACKUP="/etc/resolv.conf.backup"

sudo mv $CONF_FILE_BACKUP $CONF_FILE

echo "DNS nameservers have been successfully updated."