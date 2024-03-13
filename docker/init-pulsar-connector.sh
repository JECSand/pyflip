#!/bin/bash

# Initialize the MongoDB source connector
./bin/pulsar-admin sources localrun \
  --sourceConfigFile /mongo-source-config.yaml

echo "MongoDB source connector initialized."
