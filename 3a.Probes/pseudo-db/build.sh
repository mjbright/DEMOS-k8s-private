#!/usr/bin/env bash

IMAGE="mjbright/flask_db:0.1"

CMD="sudo podman login"
echo; echo "-- $CMD"; $CMD

CMD="sudo podman build -t $IMAGE ."
echo; echo "-- $CMD"; $CMD

CMD="sudo podman push $IMAGE"
echo; echo "-- $CMD"; $CMD

echo; echo "Built image $IMAGE"
