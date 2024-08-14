#!/bin/bash

cd $( dirname $0 )

# Assumes NFS is already configured on all nodes using NFS volume at /mnt/nfs-vol

CP="cp"
WO="worker"
CP_IP=$( hostname -i )

ssh="ssh -i ~/.ssh/t-key.pem $WO"

die() { echo "$0: die - $*" >&2; exit 1; }

grep -q " $CP" /etc/hosts || die "No '$CP' entry in /etc/hosts"
grep -q " $WO" /etc/hosts || die "No '$WO' entry in /etc/hosts"

$ssh uptime || die "Can't ssh to '$WO'"
$ssh grep -q " $CP" /etc/hosts || die "No '$CP' entry in worker:/etc/hosts"

sed -e "s/__NFS_SERVER__/$CP/" < template_deployment.yaml > deployment.yaml
diff template_deployment.yaml deployment.yaml

echo; echo "-- Setting up NFS provisioner:"
kubectl create -f rbac.yaml 
kubectl create -f deployment.yaml 
kubectl create -f class.yaml 

kubectl get storageclasses,pv,pvc


