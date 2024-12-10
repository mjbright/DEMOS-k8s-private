#!/usr/bin/env bash

# while true; do echo "---- oneshot:"; kubectl logs test-cm -c test-cm-oneshot; echo "---- looper:"; kubectl logs test-cm -c test-cm-looper; done


SLEEP=5

while true; do
    while ! kubectl get pod -l app=test-cm | grep -q Running; do
        echo "Waiting for running Pod (with label app=test-cm)"
        sleep 2
    done
    #POD1=$( kubectl get pod -l app=test-cm -o name --no-headers | grep -m1 Running | awk '{ print $1; }' )
    POD1=$( kubectl get pod -l app=test-cm | grep -m1 Running | awk '{ print $1; }' )
    echo POD1=$POD1
    [ ! -z "$POD1" ] && {
        #set -x; kubectl logs $POD1 -f -c test-cm-looper; set +x
        set -x; kubectl logs $POD1 -c test-cm-looper; set +x
    }
    echo "Sleeping $SLEEP secs ...";    sleep $SLEEP
done


