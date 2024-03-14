#!/bin/bash

sleep 5
mongoimport --uri=mongodb://mongo1:27017/geoglify?replicaSet=rs0 --collection ships --type json --file /mongo-seed/ships.json --jsonArray
