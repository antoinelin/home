#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $DIR
cd ..

CONFIG_FILE="/etc/netplan/60-custom-dns.yaml"

touch $CONFIG_FILE

cat << EOF | sudo tee "$CONFIG_FILE"
network:
  version: 2
  renderer: networkd
  ethernets:
    enp1s0:
      dhcp4: true
      dhcp4-overrides:
        use-dns: no
      nameservers:
        addresses:
          - 10.2.0.3
          - 1.1.1.1
          - 1.0.0.1
EOF

sudo netplan apply

# healthcheck
echo "Healthcheck DNS server... (5 seconds)"
sleep 5

DNS_RECORD_TEST="home.sidevision.io"

if host "$DNS_RECORD_TEST" > /dev/null; then
    echo "DNS server have been successfully installed."
else
    echo "DNS resolution failed for $DNS_RECORD_TEST."
    exit 1
fi

echo "DNS nameservers has been successfully updated. DNS server is ready to use."