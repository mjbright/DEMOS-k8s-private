
cd $(dirname $0)
echo "cd $(dirname $0)"

MNT_PT=/mnt/efs-mount-point 

EFS_ID=fs-0e5bf733ebdffeb1e

REGION="us-west-1"
REGION_AZ="us-west-1a"

# MT_DNS="us-west-1a.fs-0e5bf733ebdffeb1e.efs.us-west-1.amazonaws.com"
# DNS="fs-0e5bf733ebdffeb1e.efs.us-west-1.amazonaws.com"

MT_DNS="${REGION_AZ}.${EFS_ID}.efs.${REGION}.amazonaws.com"
DNS="${EFS_ID}.efs.${REGION}.amazonaws.com"

SETUP_EFS_NFS() {
    sudo apt-get install -y nfs-common
    #nfs-kernel-server

    sudo mkdir -p $MNT_PT

    #sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $MT_DNS:/ $MNT_PT
    sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $MT_DNS:/ $MNT_PT
}

#SETUP_EFS_NFS

echo "kubectl create configmap efs-provisioner --from-literal=file.system.id=${EFS_ID} --from-literal=aws.region=${REGION} --from-literal=provisioner.name=aws-efs" > create_efs_configmap.sh
chmod +x create_efs_configmap.sh

sed "s/REPLACE_SERVER/${DNS}/" < ./template_efs_deployment.yaml > ./efs_deployment.yaml
#sed "s/REPLACE_SERVER/${MT_DNS}/" < ./template_efs_deployment.yaml > ./efs_deployment.yaml

set -x
./create_efs_configmap.sh
echo
kubectl apply -f ./efs_deployment.yaml
echo
kubectl apply -f ./efs_sc.yaml
set +x



