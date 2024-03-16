#!/bin/bash

# Wait for Dashboard to fully start
echo "Waiting for Dashboard to start..."
until nc -z dashboard 7750; do
    sleep 1
done

echo "Dashboard started, setting up admin user..."

CSRF_TOKEN=$(curl http://dashboard:7750/pulsar-manager/csrf-token)
curl \
    -H "X-XSRF-TOKEN: $CSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$CSRF_TOKEN;" \
    -H 'Content-Type: application/json' \
    -X PUT http://dashboard:7750/pulsar-manager/users/superuser \
    -d '{"name": "admin", "password": "apachepulsar", "description": "test", "email": "username@test.org"}'