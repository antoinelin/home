#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $DIR
cd ..

# Stop the node_exporter service
echo "Stopping prometheus-node-exporter service..."
systemctl stop prometheus-node-exporter

# Disable the service to prevent it from starting on boot
echo "Disabling prometheus-node-exporter service..."
systemctl disable prometheus-node-exporter

# Remove the systemd service file
echo "Removing prometheus-node-exporter service file..."
rm -f /etc/systemd/system/prometheus-node-exporter.service
rm -f /lib/systemd/system/prometheus-node-exporter.service

# Reload systemd to apply changes
systemctl daemon-reload
systemctl reset-failed

# Remove the node_exporter binary
rm -f /bin/prometheus-node-exporter

echo "node_exporter has been successfully uninstalled."
