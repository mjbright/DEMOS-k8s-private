#!/bin/bash


INSTALL_CONSUL_SERVICEMESH() {
    kubectl get ns
    mkdir -p ~/src/
    git clone https://github.com/hashicorp/learn-consul-kubernetes.git ~/src/hashicorp.learn-consul-kubernetes

    cd ~/src/hashicorp.learn-consul-kubernetes

    echo
    echo "In another window:"
    echo "    watch kubectl get pv,pvc -A"
    consul-k8s install -f config.yaml
}

INSTALL_CONSUL_K8S_CLI() {
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update && sudo apt-get install consul-k8s

    echo
    which consul-k8s
    consul-k8s version
    consul-k8s install -dry-run
    #consul-k8s status
}

# INSTALL_CONSUL_K8S_CLI
INSTALL_CONSUL_SERVICEMESH


