#!/bin/bash

# mongoimport --username root --password root --host mongodb --port 27017 --db geoglify --mode upsert --collection ships --authenticationDatabase=admin --type json --file /mongo-seed/ships.json --jsonArray
mongoimport --uri=mongodb://mongo1:27017/?replicaSet=rs0 --db geoglify --mode upsert --collection ships --authenticationDatabase=admin --type json --file /mongo-seed/ships.json --jsonArray
