#!/bin/bash

# Check if the container already exists
if [ "$(docker ps -aq -f name=oracle-xe)" ]; then
    # Start the existing container
    echo "Starting existing container: oracle-xe"
    docker start oracle-xe
else
    # Run a new container
    echo "Creating and starting new container: oracle-xe"
    docker run --name oracle-xe \
    -p 1521:1521 -p 5500:5500 \
    -e ORACLE_PWD=parola \
    container-registry.oracle.com/database/express:21.3.0-xe
fi