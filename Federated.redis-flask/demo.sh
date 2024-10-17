#!/usr/bin/env bash

cd $( dirname $0 )

. ../demos.rc

STEP=""

while [ ! -z "$1" ]; do
    case $1 in
       -x) set -x;;

        v[0-9]*) 
             [ ! -d "$1" ] && die "Expected directory name of form v[0-9]*"
             STEP="$1"
             ;;

        *) die "Unknown option '$1'";;
    esac
    shift
done

RUN_STEP() {
    STEP="$1"; shift

    STEP_HEADER "Running step $STEP"
    PRESS
}

if [ -z "$STEP" ]; then
    DEMO_HEADER "Running all demo steps ..."
    for STEP in $(  ls -1d v0.* | sort ); do
        RUN_STEP $STEP
    done
else
    RUN_STEP $STEP
fi


# v0.1_deploy_service/
# v0.2_scaled_flask_fe/
# v0.3_upgrade/
# v0.4_helm_import/
# v0.8_helm_scheduling/
# v0.6_helm_values/
# v0.5_helm_imported/

