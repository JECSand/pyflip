#!/bin/bash

sleep 10
echo "MongoDB source connector initializing."
# Initialize the MongoDB source connector
./bin/pulsar-admin sources localrun \
  --sourceConfigFile /mongo-connectors/source/mongo-source-config.yaml

echo "MongoDB source connector initialized."
