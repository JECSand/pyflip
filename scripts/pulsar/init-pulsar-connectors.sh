#!/bin/bash

echo "MongoDB source connector initializing."

# Replace '/path/to/directory' with the path to your directory
MONGODB_SOURCE_DIRECTORY='/mongo-connectors/source'
MONGODB_SINK_DIRECTORY='/mongo-connectors/sink'


# Initialize the MongoDB source connectors
echo "Initializing MongoDB Source Connectors"
for file in "$MONGODB_SOURCE_DIRECTORY"/*
do
  if [[ -f "$file" && ( "$file" == *.yaml || "$file" == *.yml )  ]]; then
    ./bin/pulsar-admin sources create \
      --sourceConfigFile "$file"
  fi
done

# Initialize the MongoDB source connectors
echo "Initializing MongoDB Sink Connectors"
for file in "$MONGODB_SINK_DIRECTORY"/*
do
  if [[ -f "$file" && ( "$file" == *.yaml || "$file" == *.yml )  ]]; then
    ./bin/pulsar-admin sinks create \
      --sink-type mongo \
      --sink-config-file "$file"
  fi
done

echo "MongoDB sink connector initialized."
