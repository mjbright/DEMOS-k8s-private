
# TODO:

EXPLORE use of storageClassName versus use of annotation: same thing?
  I currently use one or other

# StatefulSet Deletion (Volumes are not deleted):

NOTE: Deleting the Pods in a StatefulSet will not delete the associated volumes.
      This is to ensure that you have the chance to copy data off the volume before deleting it.
      Deleting the PVC after the pods have terminated might trigger deletion of the backing Persistent Volumes depending on the storage class and reclaim policy.
      You should never assume ability to access a volume after claim deletion.

Note: Use caution when deleting a PVC, as it may lead to data loss.

### Complete deletion of a StatefulSet

To delete everything in a StatefulSet, including the associated pods, you can run a series of commands similar to the following:

```
grace=$(kubectl get pods <stateful-set-pod> --template '{{.spec.terminationGracePeriodSeconds}}')
kubectl delete statefulset -l app.kubernetes.io/name=MyApp
sleep $grace
kubectl delete pvc -l app.kubernetes.io/name=MyApp
```



https://kubernetes.io/docs/tasks/run-application/delete-stateful-set/

# TODO:

Export location other than /mnt/nfs-vol !!
Mount at common location (not /mnt)

Use syncing between statefulset Pods

Implement flask/redis counter with
- multiple replicas, statefulset, only one writer
- ingress access to service

# nfs-provisioner

Based on 
- https://opensource.com/article/20/6/kubernetes-nfs-client-provisioning
  - NOTE: need different deployment for ARM/Raspberry Pi
- Issue in k8s 1.20+ (removal of selfLink):
  - https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner/issues/25
  - changed image for nfs-provisioner to use gcr.io/k8s-staging-sig-storage/nfs-subdir-external-provisioner:v4.0.0

# To try next

- Read article, study manifests
- Setup to provide provisioning for Consul
- Setup to provide provisioning for Grafana Cloud
- Setup for StatefulSet

# history

  mkdir nfs-provisioner
  cd nfs-provisioner

  #git clone https://github.com/kubernetes-incubator/external-storage.git ~/src//kubernetes-incubator.external-storage
  ll ~/src//kubernetes-incubator.external-storage/nfs-client/deploy/
  cp -a ~/src//kubernetes-incubator.external-storage/nfs-client/deploy/ .
  ll deploy/objects/
  ll deploy/
  cp -a deploy/rbac.yaml  .
  vi rbac.yaml 
  kubectl create -f rbac.yaml 
  ll deploy/deployment.yaml 
  cp -a deploy/deployment.yaml  .
  vi deployment.yaml 
  kubectl create -f deployment.yaml 
  kubectl get all
  kubectl get pv,pvc
  ll deploy/class.yaml 
  cp -a deploy/class.yaml  .
  vi class.yaml 
  kubectl create -f class.yaml 
  kubectl get storageclasses.storage.k8s.io 
  kubectl get pv,pvc
  cp -a deploy/test-claim.yaml .
  cp -a deploy/test-pod.yaml .
  vi test-claim.yaml 
  kubectl create -f test-pod.yaml 
  kubectl get pods
  kubectl describe pods test-pod 
  kubectl get pv,pvc
  kubectl create -f test-claim.yaml 
  kubectl get pv,pvc
  kubectl get storageclasses.storage.k8s.io 
  kubectl get pv,pvc
  kubectl get storageclasses.storage.k8s.io 
  cat /etc/exports 
  kubectl get po
  kubectl logs nfs-client-provisioner-789cbcb5d4-zdnmp 
  ll
  vi deployment.yaml 
  kubectl apply -f deployment.yaml 
  kubectl get po
  kubectl get pv,pvc
  kubectl logs nfs-client-provisioner-76446477db-44vdw 
  kubectl get pv,pvc
  kubectl get pods
  ll /mnt/nfs-vol/
  ll /mnt/nfs-vol/default-test-claim-pvc-e6065efa-396c-49b0-9137-552f65a46c6a/
  ll /mnt/nfs-vol/default-test-claim-pvc-e6065efa-396c-49b0-9137-552f65a46c6a/SUCCESS 
  rm -rf deploy/
