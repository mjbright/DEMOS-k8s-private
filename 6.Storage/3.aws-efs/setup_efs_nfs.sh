
cd $(dirname $0)
echo "cd $(dirname $0)"

MNT_PT=/mnt/efs-mount-point 

# To get EFS_ID: terraform output | grep efs_id
EFS_ID=fs-0b7498c1434892ffd

REGION="us-west-1"
REGION_AZ="us-west-1a"

# MT_DNS="us-west-1a.fs-0e5bf733ebdffeb1e.efs.us-west-1.amazonaws.com"
# DNS="fs-0e5bf733ebdffeb1e.efs.us-west-1.amazonaws.com"

# NOTE: This worked for sudo mount:
#   MT_DNS=fs-0b7498c1434892ffd.efs.us-west-1.amazonaws.com
#   sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $MT_DNS: /mnt/efs-mount-point/
# BUT
#   showmount -e blocks on all addresses ...

MT_DNS="${REGION_AZ}.${EFS_ID}.efs.${REGION}.amazonaws.com"
DNS="${EFS_ID}.efs.${REGION}.amazonaws.com"

if [ "$1" = "-rm" ]; then
    kubectl -n storage delete -f yaml
    kubectl -n storage delete configmap efs-provisioner
    exit $?
fi

SETUP_EFS_NFS() {
    sudo apt-get install -y nfs-common
    #nfs-kernel-server

    sudo mkdir -p $MNT_PT

    echo; echo "-- Testing mounting of efs volume $EFS_ID as an NFS mount:"
    #sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $MT_DNS:/ $MNT_PT
    #sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $MT_DNS:/ $MNT_PT
    set -x
    sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $DNS:/ $MNT_PT
    set +x
    sudo mount | grep nfs

    echo; echo "Unmounting ..."
    sudo umount $MNT_PT
}

SETUP_EFS_NFS

#echo "kubectl create configmap efs-provisioner --from-literal=file.system.id=${EFS_ID} --from-literal=aws.region=${REGION} --from-literal=provisioner.name=aws-efs" > create_efs_configmap.sh
#chmod +x create_efs_configmap.sh

sed "s/REPLACE_SERVER/${DNS}/" < template_efs-deployment.yaml > yaml/efs-deployment.yaml
#sed "s/REPLACE_SERVER/${MT_DNS}/" < template_efs-deployment.yaml > yaml/efs-deployment.yaml

set -x
#./create_efs_configmap.sh
kubectl -n storage create configmap efs-provisioner \
    --from-literal=file.system.id=${EFS_ID} \
    --from-literal=aws.region=${REGION} \
    --from-literal=dns.name="" \
    --from-literal=provisioner.name=aws-efs

echo
echo
kubectl -n storage create -f yaml/efs-serviceaccount.yaml 
echo
kubectl -n storage create -f yaml/efs-rbac.yaml 
echo
kubectl -n storage apply -f yaml/efs-deployment.yaml
echo
kubectl -n storage apply -f yaml/efs-sc.yaml
echo
kubectl get storageclass
set +x

echo
echo "Press <return>"
read

while true; do
  echo
  kubectl get po -n storage
  echo
  kubectl -n storage describe pod -l app=efs-provisioner | grep -A 100 Events:
  sleep 5
done

