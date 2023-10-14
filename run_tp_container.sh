#!/bin/bash

docker run \
    --name qtappcontainer \
    --mount type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix \
    -e DISPLAY=:0 \
    --cpus=1 \
    --memory=100m \
    --cpu-shares=512 \
    --read-only \
    --tmpfs /app/tmp:uid=$(id -u $USER),gid=$(id -g $USER),mode=0700 \
    --tmpfs /tmp/runtime-dockeruser:uid=$(id -u $USER),gid=$(id -g $USER),mode=0700 \
    -e XDG_RUNTIME_DIR=/app/tmp \
    -u $(id -u $USER):$(id -g $USER) \
    --rm \
    qtapp 

