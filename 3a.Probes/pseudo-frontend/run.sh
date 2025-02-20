#!/usr/bin/env bash
#
IMAGE="mjbright/flask_fe:0.1"

CMD="sudo podman run -d $IMAGE"
echo; echo "-- $CMD"; $CMD

