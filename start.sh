#!/bin/bash

IMAGE_NAME="arch_image"
CONTAINER_NAME="arch_joke"

# イメージが存在しない場合、Dockerfileからビルドする
if ! docker images | grep -q "$IMAGE_NAME"; then
  echo "Building Docker image $IMAGE_NAME ..."
  docker build -t $IMAGE_NAME .
fi

# コンテナが実行中でない場合、起動する
if ! docker ps | grep -q "$CONTAINER_NAME"; then
  # コンテナが存在している場合は削除する
  if docker ps -a | grep -q "$CONTAINER_NAME"; then
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
  fi

  echo "Starting Docker container $CONTAINER_NAME ..."
  docker run -it -d --rm --name $CONTAINER_NAME $IMAGE_NAME /bin/bash
else
  echo "Docker container $CONTAINER_NAME is already running."
fi
