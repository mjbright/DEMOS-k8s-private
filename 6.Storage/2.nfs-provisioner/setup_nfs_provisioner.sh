#!/bin/bash

cd $( dirname $0 )

# Assumes NFS is already configured on all nodes using NFS volume at /mnt/nfs-vol

# BUT IN CASE:
[ ! -d /mnt/nfs-vol ] && sudo mkdir /mnt/nfs-vol
sudo chmod 777 /mnt/nfs-vol
grep /mnt/nfs-vol /etc/exports ||
    echo '/mnt/nfs-vol/ *(rw,sync,no_root_squash,subtree_check)' | {
        sudo tee -a /etc/exports
        sudo exportfs -ra
    }
showmount -e $CP

CP="k8scp"
WO="worker"
CP_IP=$( hostname -i )

KEY=~/.ssh/t-key.pem
KEY=~/.ssh/student2022_rsa
ssh="ssh -i $KEY $WO"

die() { echo "$0: die - $*" >&2; exit 1; }

grep -q " $CP" /etc/hosts || die "No '$CP' entry in /etc/hosts"
grep -q " $WO" /etc/hosts || die "No '$WO' entry in /etc/hosts"

dpkg -l | grep "^ii" | grep nfs-common        || die "cp: nfs-common is not installed"
dpkg -l | grep "^ii" | grep nfs-kernel-server || die "cp: nfs-kernel-server is not installed"
$ssh dpkg -l | grep "^ii" | grep nfs-common   || die "worker: nfs-common is not installed"

$ssh uptime || die "Can't ssh to '$WO'"
$ssh grep -q " $CP" /etc/hosts || die "No '$CP' entry in worker:/etc/hosts"

# Create storage namespace if it doesn't exist already:
kubectl get ns | grep -q storage ||
    kubectl create ns storage

sed -e "s/__NFS_SERVER__/$CP/" < template_deployment.yaml > deployment.yaml
diff template_deployment.yaml deployment.yaml

echo; echo "-- Setting up NFS provisioner:"
kubectl -n storage create -f rbac.yaml 
kubectl -n storage create -f deployment.yaml 
kubectl -n storage create -f class.yaml 

kubectl -n storage get storageclasses,pv,pvc


