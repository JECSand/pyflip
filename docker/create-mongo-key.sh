#!/bin/bash

openssl rand -base64 756 > mongo-keyfile
chmod 400 mongo-keyfile