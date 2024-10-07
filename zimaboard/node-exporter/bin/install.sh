#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $DIR
cd ..

NODE_EXPORTER_VERSION=1.8.2

if [ -z "$PRIVATE_IP" ]; then
    echo "PRIVATE_IP is not set."
    exit 1
fi

# Download and uncompress node_exporter
echo "Downloading and uncompressing node_exporter..."
wget "https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.darwin-amd64.tar.gz"
tar xvfz "node_exporter-${NODE_EXPORTER_VERSION}.darwin-amd64.tar.gz"

# Move the binary to /bin
mv ./node_exporter-${NODE_EXPORTER_VERSION}.darwin-amd64/node_exporter /bin/prometheus-node-exporter

# Create systemd service file
echo "Creating systemd service file..."
cat << EOF | sudo tee /lib/systemd/system/prometheus-node-exporter.service > /dev/null
[Unit]
Description=Prometheus node_exporter server to scrap metrics from system.

[Service]
Type=simple
ExecStart=/bin/prometheus-node-exporter

[Install]
WantedBy=multi-user.target
EOF

# Copy the unit file to /etc/systemd/system and set permissions
cp /lib/systemd/system/prometheus-node-exporter.service /etc/systemd/system/
chmod 644 /etc/systemd/system/prometheus-node-exporter.service

# Reload systemd to recognize the new service
systemctl daemon-reload

# Start and enable the service
echo "Enabling and starting prometheus-node-exporter service..."
systemctl start prometheus-node-exporter
systemctl enable prometheus-node-exporter

# Remove downloaded files
rm -rf ./node_exporter-${NODE_EXPORTER_VERSION}.darwin-amd64.tar.gz ./node_exporter-${NODE_EXPORTER_VERSION}.darwin-amd64

# healthcheck
echo "Healthcheck node-exporter... (5 seconds)"
sleep 5
sudo wget --no-verbose --tries=1 --spider http://$PRIVATE_IP:9100/ready || exit 1

# Display the status of the service
echo "Prometheus node_exporter service installed and started successfully."
