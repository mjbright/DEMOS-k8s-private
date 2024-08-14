
# TODO:

Export location other than /opt/sfw !!
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
  ll /opt/sfw/
  ll /opt/sfw/default-test-claim-pvc-e6065efa-396c-49b0-9137-552f65a46c6a/
  ll /opt/sfw/default-test-claim-pvc-e6065efa-396c-49b0-9137-552f65a46c6a/SUCCESS 
  rm -rf deploy/
