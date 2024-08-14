#!/bin/bash

cd $(dirname $0)
pwd


INSTALL_LOCAL_STORAGE_PROVIDER() {
    wget -qO pod.yaml \
        https://raw.githubusercontent.com/rancher/local-path-provisioner/master/examples/pod/pod.yaml

    #kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
    wget -qO local-path-storage.0.yaml \
        https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

    sed 's/local-path-storage/storage/' < local-path-storage.0.yaml > local-path-storage.yaml
    kubectl apply -f local-path-storage.yaml
}

## #wget https://raw.githubusercontent.com/rancher/local-path-provisioner/master/examples/pvc.yaml
## wget https://raw.githubusercontent.com/rancher/local-path-provisioner/master/examples/pvc/pvc.yaml

INSTALL_LOCAL_STORAGE_PROVIDER

kubectl get storageclass

