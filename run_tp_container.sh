#!/bin/bash

docker run \
    --name qtappcontainer \
    --mount type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix \
    -e DISPLAY=:0 \
    -e XDG_RUNTIME_DIR=/app/tmp \
    -u $(id -u $USER):$(id -g $USER) \
    --rm \
    qtapp 

