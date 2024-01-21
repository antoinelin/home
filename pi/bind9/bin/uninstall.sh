#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $DIR
cd ..

docker compose down

RESOLVED_CONF_FILE="/etc/systemd/resolved.conf"
RESOLVED_CONF_FILE_BACKUP="/etc/systemd/resolved.conf.backup"

mv $RESOLVED_CONF_FILE_BACKUP $RESOLVED_CONF_FILE
