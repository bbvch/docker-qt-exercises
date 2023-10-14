#!/bin/bash

docker run \
    --name qtappcontainer \
    --mount type=bind,source=./src,target=/app \
    --mount type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix \
    -e DISPLAY=:0 \
    -e XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR} \
    --rm \
    -it \
    qtapp /bin/bash

