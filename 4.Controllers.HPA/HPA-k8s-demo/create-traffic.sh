#!/usr/bin/env bash


kubectl get svc deploy-example >/dev/null 2>&1 ||
    kubectl expose deployment deploy-example --cluster-ip  10.100.0.20 --port 80

kubectl get svc deploy-example

if [ "$1" = "-fast" ]; then
    which ab || {
	    echo "Installing ab ..."
	    CMD="sudo apt-get install -y apache2-utils"
	    echo "-- $CMD"; $CMD
    }
    ab -n 1000000 http://10.100.0.20/1
    #kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c \
        #"while true; do wget -q -O/dev/null http://deploy-example/1; done"
else
    kubectl get pod load-generator 2>/dev/null  && kubectl delete pod load-generator
    kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c \
        "while sleep 0.01; do wget -q -O- http://deploy-example/1; done"
fi



