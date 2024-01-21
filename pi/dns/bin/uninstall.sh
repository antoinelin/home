#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $DIR
cd ..

rm -f /etc/netplan/60-custom-dns.yaml
sudo netplan apply

echo "DNS nameservers have been successfully updated."