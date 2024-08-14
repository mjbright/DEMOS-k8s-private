
# NOTE: data location

On node where Pod is scheduled, pvc is generated under
    /opt/local-path-provisioner/A

e.g.
    /opt/local-path-provisioner/pvc-91d40cc8-be64-46d9-ab39-705e575426e3_default_local-path-pvc/

In Pod this volume is mounted at /data (as per Pod spec / volumeMount)

When done remember to delete Pod, then delete PVC (not PV!! PV will then get auto-deleted)

# History

   mkdir TAKE/local-path-provisioner
   vi TAKE/local-path-provisioner/setup.sh
   chmod +x TAKE/local-path-provisioner/setup.sh
   TAKE/local-path-provisioner/setup.sh

   # more TAKE/local-path-provisioner/pvc.yaml 
   # more TAKE/local-path-provisioner/pod.yaml 
   kubectl create -f TAKE/local-path-provisioner/pvc.yaml 

   kubectl get pv,pvc

   kubectl create -f TAKE/local-path-provisioner/pod.yaml 

   kubectl get pv,pvc
   kubectl get pv,pvc
   kubectl get pv,pvc
   kubectl get pv,pvc

   clear; kubectl get pv,pvc

   kubectl get pod

   kubectl exec local-volume-test -- sh -c "echo local-path-test > /data/find.me.log"
   kubectl exec local-volume-test -- sh -c "cat /data/find.me.log"

   #kubectl exec -it local-volume-test -- sh

   kubectl get pods -o wide

   sudo find / -name find.me.log 2>/tmp/x
   ssh worker sudo find / -name find.me.log
   ssh t-kube-2 sudo find / -name find.me.log

