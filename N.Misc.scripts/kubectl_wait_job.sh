#!/bin/sh

# See: https://stackoverflow.com/questions/55303430/kubectl-wait-waits-forever

kubectl wait --for=condition=complete --timeout=24h job/longrunningjobname




