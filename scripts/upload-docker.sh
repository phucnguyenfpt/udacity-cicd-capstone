#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
dockerpath="toliv22"
MY_PASSWORD=nhomaimotnguoi
CONTAINER_NAME="capstone"
VERSION=v1.0.0



# Step 2:
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
# docker login --username ${dockerpath}
echo "$MY_PASSWORD" | docker login --username $dockerpath --password-stdin
image_tagged=$(docker image list --filter=reference="$dockerpath/$CONTAINER_NAME" | grep $CONTAINER_NAME | xargs)
if [[ -n $image_tagged ]]; then
  echo "Image already tagged, remove the tagged image."
  name=$(echo "$image_tagged" | cut -f 1 -d " ")
  tag=$(echo "$image_tagged" | cut -f 2 -d " ")
  docker image remove --force "$name":"$tag"
fi
image_info=$(docker image list | grep $CONTAINER_NAME | xargs)
image_name=$(echo "$image_info" | cut -f 1 -d " ")
image_tag=$(echo "$image_info" | cut -f 2 -d " ")
docker image tag "$image_name:$image_tag" "$dockerpath/$image_name:$image_tag"
docker image list --filter=reference="$dockerpath/$CONTAINER_NAME:$VERSION"

# Step 3:
# Push image to a docker repository
docker image push "$dockerpath/$CONTAINER_NAME:$VERSION"
