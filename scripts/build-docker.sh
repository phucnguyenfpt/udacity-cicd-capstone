#!/usr/bin/env bash

CONTAINER_NAME="capstone"
VERSION=v1.0.0

# Step 1:
# Build image and add a descriptive tag
docker build --tag ${CONTAINER_NAME}:${VERSION} .

# Step 2: 
# List docker images
docker image list


# Step 3:
# Run flask app
docker run --detach --publish 8000:80 ${CONTAINER_NAME}:${VERSION}
