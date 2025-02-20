#!/usr/bin/env bash

SLEEP=10

while true; do
    echo
    echo "-- $(date): " $( kubectl get deployments.apps deploy-example --no-headers )
    kubectl get hpa hpa-example
    sleep $SLEEP
done

