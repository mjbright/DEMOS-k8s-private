#!/bin/bash

cd $(dirname $0)
pwd

kubectl create -f .

kubectl get storageclass,pv,pvc,pod

