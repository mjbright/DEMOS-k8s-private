

cd $(dirname $0)

# Assumes NFS is already configured on all nodes using NFS volume at /mnt/nfs-vol

echo; echo "-- Using NFS provisioner:"

kubectl get storageclasses,pv,pvc
sudo find /mnt/nfs-vol/

echo; echo "kubectl create -f pvc.yaml"
kubectl create -f pvc.yaml
echo; echo "kubectl create -f deployment.yaml"
kubectl create -f deployment.yaml

sleep 2
echo "Pod should now be running:"
kubectl get pods,pv,pvc

sudo find /mnt/nfs-vol/


