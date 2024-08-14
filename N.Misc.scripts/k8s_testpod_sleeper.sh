#!/bin/bash

SLEEP=$(( 24 * 3600 ))
[ ! -z "$1" ] && SLEEP=$1

set -x; kubectl run testpod --image alpine -- /bin/sleep $SLEEP
