#!/bin/bash

cd $(dirname $0)
pwd


INSTALL_LOCAL_STORAGE_PROVIDER() {
    kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
}

## #wget https://raw.githubusercontent.com/rancher/local-path-provisioner/master/examples/pvc.yaml
## wget https://raw.githubusercontent.com/rancher/local-path-provisioner/master/examples/pvc/pvc.yaml

wget https://raw.githubusercontent.com/rancher/local-path-provisioner/master/examples/pod/pod.yaml



