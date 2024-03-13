#!/bin/bash

# URL of the MongoDB connector JAR file
CONNECTOR_JAR_URL="https://www.apache.org/dyn/closer.lua/pulsar/pulsar-3.2.1/connectors/pulsar-io-mongo-3.2.1.nar"

# Path where the connector JAR will be stored
CONNECTOR_JAR_PATH="/pulsar/connectors/pulsar-io-mongodb-3.2.1.nar"

# Wait for Pulsar to fully start
echo "Waiting for Pulsar to start..."
until nc -z pulsar 6650; do
    sleep 1
done

echo "Pulsar started, downloading MongoDB source connector..."

# Download the MongoDB connector JAR
wget -O "$CONNECTOR_JAR_PATH" "$CONNECTOR_JAR_URL"

# Check if the download was successful
if [ ! -f "$CONNECTOR_JAR_PATH" ]; then
    echo "Failed to download the MongoDB source connector."
    exit 1
fi