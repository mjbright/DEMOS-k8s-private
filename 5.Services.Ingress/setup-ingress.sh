#!/bin/bash

cd $( dirname $0 )

. demos.rc

# Namespace where Ingress-Controller is to be insgtalled
IC_NS=nginx-ingress

# TODO: experiment with multiple Ingress-Controllers
# TODO: add TLS secret
# TODO: try Kubernetes GW API

die() { echo -e "$0: die - $*" >&2; exit 1; }

## Funcs: ------------------------------------------------------------------------------

UNINSTALL() {
    set -x
    helm uninstall   myingress
    helm repo remove ingress-nginx
    set +x
}

INSTALL_INGRESS() {
    RUN_PRESS helm search hub ingress

    RUN_PRESS helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

    RUN_PRESS helm repo update

    RUN_PRESS helm fetch ingress-nginx/ingress-nginx --untar

    RUN_PRESS helm install -n $IC_NS --create-namespace myingress ./ingress-nginx/
}

STOP_BE_SERVICES() {
    set -x
    kubectl  delete deploy --all
    kubectl delete service --all
    set +x
    #kubectl delete deploy e404
    #kubectl delete deploy web 
    #kubectl delete deploy vote
    #kubectl delete deploy quiz
}

START_BE_SERVICES() {
    # RUN_PRESS kubectl create deploy e404 --image mjbright/banner:404 --replicas 1
    # RUN_PRESS kubectl expose deploy e404 --port 80
    RUN_PRESS kubectl create deploy web  --image mjbright/k8s-demo:1 --replicas 2
    RUN_PRESS kubectl expose deploy web  --port 80
    RUN_PRESS kubectl create deploy vote --image mjbright/banner:vote --replicas 3
    RUN_PRESS kubectl expose deploy vote --port 80
    RUN_PRESS kubectl create deploy quiz --image mjbright/banner:quiz --replicas 3
    RUN_PRESS kubectl expose deploy quiz --port 80
}

CREATE_INGRESS_RULES() {
    RUN_PRESS kubectl create -f ingress.yaml
}

SHOW_CURL_COMMAND() {
    echo; echo "-- kubectl get svc -n $IC_NS | grep ingress"
    kubectl get svc -n $IC_NS | grep ingress

    NODEPORT=$( kubectl get svc -n $IC_NS | awk '/myingress-ingress-nginx-controller / { print $5; }' | sed -e 's/.*80://' -e 's?/TCP.*??' )
    IP=$( curl -sL ifconfig.io )

    echo; echo "NODEPORT for Ingress Controller is $NODEPORT"

    echo; echo "Curl:"
    echo; echo "    curl -H 'Host: quiz.mjbright.click' localhost:${NODEPORT}"
    echo; echo "    curl -H 'Host: vote.mjbright.click' localhost:${NODEPORT}"
    echo; echo "    curl -H 'Host: web.mjbright.click' localhost:${NODEPORT}"
    echo; echo "Browse to:"
    echo; echo "    quiz.mjbright.click:${NODEPORT}"
    echo; echo "    vote.mjbright.click:${NODEPORT}"
    echo; echo "    web.mjbright.click:${NODEPORT}"
}

## Args: ------------------------------------------------------------------------------

if [ "$1" = "-p" ]; then
    SHOW_CURL_COMMAND
    exit
fi

if [ "$1" = "-d" ]; then
    UNINSTALL
    STOP_BE_SERVICES
    exit
fi

## Main: ------------------------------------------------------------------------------

INSTALL_INGRESS
START_BE_SERVICES
CREATE_INGRESS_RULES

SHOW_CURL_COMMAND

exit 0


