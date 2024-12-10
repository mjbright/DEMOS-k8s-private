#!/usr/bin/env bash

echo "[$(date)] About to update CM cm1"
#read -p "[$(date)] About to update CM cm1"
kubectl apply -f cm1.NEW-VALUE.yaml

exit

#cm1.yaml
#deploy_cm.stakater.yaml
