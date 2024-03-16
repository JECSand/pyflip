#!/bin/bash

echo "Pulsar functions initializing."

# Replace '/path/to/directory' with the path to your directory
FUNCTIONS_DIRECTORY='/functions'

# Initialize the MongoDB source connectors
for i in $(find "$FUNCTIONS_DIRECTORY" -type d );
do
    if [[ ( "$i" != "$FUNCTIONS_DIRECTORY/__pycache__" && "$i" != "$FUNCTIONS_DIRECTORY" ) ]]; then
      echo "Creating function: $i"
      PYTHON_FILE=$(find "$i" -name '*.py' )
      CONF_FILE=$(find "$i" -name '*.yaml' )
      ./bin/pulsar-admin functions create \
        --function-config-file "$CONF_FILE" \
        --py "$PYTHON_FILE"
      echo "Function: $i created!"
    fi
done

echo "Pulsar functions initialized."
