
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

