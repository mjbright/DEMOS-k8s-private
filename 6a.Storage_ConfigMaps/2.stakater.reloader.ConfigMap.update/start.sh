#!/usr/bin/env bash

DEPLOY0=deploy_cm.yaml
DEPLOY=$DEPLOY0
if [ "$1" = "-s" ]; then
    DEPLOY=deploy_cm.stakater.yaml
    echo "Using deployment with 'stakater/reloader' annotation"
    set -x; diff $DEPLOY0 $DEPLOY; set +x

    set -x
      kubectl apply -f https://raw.githubusercontent.com/stakater/Reloader/master/deployments/kubernetes/reloader.yaml
    set +x
fi

# STOP DEPLOY, REMOVE CM:
kubectl delete deploy test-cm >/dev/null 2>&1
kubectl delete cm cm1         >/dev/null 2>&1

# WAIT FOR PODS to be terminated
while kubectl get pods -l app=test-cm | grep Terminating; do sleep 2; done

echo "Creating the cm1 ConfigMap"
#read -p "About to create CM cm1"
kubectl apply -f cm1.yaml

echo "Creating the test-cm deployment"
kubectl apply -f $DEPLOY

#sleep 5
kubectl get deploy test-cm
kubectl get pod -l app=test-cm

exit

#cm1.NEW-VALUE.yaml
#cm1.yaml
