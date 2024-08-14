#
# NO: may not be seen by helm install of nfs-csi:
# - kubectl -n storage create -f nfs-provisioner-server.yaml 

# Deploys to default namespace:
# -  Deploys to fixed ClusterIP address:
# -  service/nfs-server   ClusterIP   10.96.200.2      <none>        2049/TCP,111/UDP   112s
#
# - this allows us to use ip address in PeristentVolume rather than 'nfs-server' service name
#   because it looks like the csi driver is in the host namespace and may not have access to clusterDNS !!
#
# - ???? but why do we even specify te PersistentVolume !! (in nginx-pod.yaml)????
#   BECAUSE THIS DRIVER ALLOWS IT STATICALLY OR DYNAMICALLY
#   https://github.com/kubernetes-csi/csi-driver-nfs/tree/master/deploy/example
#   ou can use NFS CSI Driver to provision Persistent Volumes statically or dynamically => see storageclass definition
# 
# Also sets volume mount to /mnt/nfs-vol
#
kubectl create -f nfs-provisioner-server.200.yaml 

helm repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts
helm install csi-driver-nfs csi-driver-nfs/csi-driver-nfs --namespace kube-system --version v4.0.0

sleep 4
kubectl -n kube-system get pod | grep csi-nfs

sleep 4
kubectl -n kube-system logs -l app=csi-nfs-controller


kubectl create -f nginx-pod.yaml 
kubectl exec nginx-nfs-example -- bash -c "findmnt /var/www -o TARGET,SOURCE,FSTYPE"
## with fixed ip address rather than nfs-server.default.svc.cluster.local
## TARGET   SOURCE        FSTYPE
## /var/www 10.96.200.2:/ nfs4


 # kubectl exec nginx-nfs-example -- bash -c "touch /var/www/TEST_FILE"
 #  kubectl exec nginx-nfs-example -- bash -c "ls -al /var/www"
 #  kubectl exec nginx-nfs-example -- bash -c "ls -al /var/www"
 #  kubectl exec nginx-nfs-example -- bash -c "cat /var/www/TEST_FILE"

