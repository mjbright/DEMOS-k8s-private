
[ "$1" = "-x" ] && set -x

CLEANUP() {
    kubectl get pods -l test=nfs-provisioner 2>&1 | grep -q "^test-pod " && {
        echo "Cleaning up old pod/test-pod ..."
        #kubectl delete -f test-pod.yaml   >/dev/null 2>&1
        kubectl delete -f test-pod.yaml   
    }
    kubectl get pvc 2>&1 | grep -q "^test-claim " && {
        echo "Cleaning up old pvc/test-claim ..."
        #kubectl delete -f test-claim.yaml >/dev/null 2>&1
        kubectl delete -f test-claim.yaml 
    }
}

CLEANUP
[ "$1" = "-rm" ] && exit

# Assumes NFS is already configured on all nodes using NFS volume at /mnt/nfs-vol

echo; echo; echo "-- Using NFS provisioner:"

kubectl get storageclasses,pv,pvc
sudo find /mnt/nfs-vol

echo; echo; echo "-- Creating test-pod (will remain Pending for now)"
kubectl create -f test-pod.yaml 
kubectl get pods -l test=nfs-provisioner

echo; echo "Press <enter> to continue (show Pod events, then create PVC)"
read
kubectl describe pods test-pod  | grep -A 10 Events: | sed 's/^Events:/Pod Events:/'

echo; echo; echo "-- Creating PVC which will create and be bound to a PV"
kubectl get pv,pvc
kubectl create -f test-claim.yaml 

#sleep 2
echo; echo; echo "Wait for Pod to be 'Running':"
echo "kubectl wait --for=condition=ready pods -l test=nfs-provisioner"
kubectl wait --for=condition=ready pods -l test=nfs-provisioner

echo;echo
kubectl get pods -l test=nfs-provisioner
echo;echo
kubectl describe pods test-pod  | grep -A 10 Events: | sed 's/^Events:/Pod Events:/'
echo;echo
kubectl get pv,pvc

echo;echo
sudo find /mnt/nfs-vol -name SUCCESS
FILE=$( sudo find /mnt/nfs-vol -name SUCCESS | tail -1 )

echo; echo "tail -f $FILE:"
tail -f $FILE

