---
title: "Demo Ideas"
lang: en
meta:
 - attribute: keywords
   value: Kubernetes
#css:
 #- https://url/to/style.css
#js:
 #- https://url/to/script.js
# NOTE: can be displayed on mac using easymd
# NOTE: easymd doesn't support links !!
---


# == Demo Ideas ==

# Demo ideas (to integrate)

# Use same numbering as labs:
- K8S-1.23.4_Lab1y_KubernetesInstall.pdf
  - TODO: make sure all apt-get install are "shown"
- K8S-1.23.6_Lab2_KubernetesIntro.pdf
- K8S-1.23.6_Lab3_Controllers.pdf
  - Show use of kubectl get --raw "/api/v1/namespaces/${namespace}/pods"
    - or /apis?
  - Show use of kubectl get --raw "/api/v1/pods"
    - or /apis?
- K8S-1.23.6_Lab4a_MoreControllers.pdf
- K8S-1.23.6_Lab4b_RollingUpgrades.pdf
- K8S-1.23.6_Lab5a_Services.pdf
- K8S-1.23.6_Lab5b_Ingress.pdf
- K8S-1.23.6_Lab5c_ServiceMesh-Istio.pdf
- K8S-1.23.6_Lab5d_ServiceMesh-Linkerd_TODO.pdf
- K8S-1.23.6_Lab6a_Volumes.pdf
- K8S-1.23.6_Lab6b_ConfigMaps.pdf
  - TODO: more complete examples, use of API as stretch goal (w. RBAC)
- K8S-1.23.6_Lab6c_Secrets.pdf
  - TODO: more complete examples, use of API as stretch goal (w. RBAC)
- K8S-1.23.6_Lab7_Observability.pdf
- K8S-1.23.6_Lab9a_Security-RBAC.pdf
  - TODO: Create kubeconfig from openssl certificates

# DEMO (& labs) ideas

>> 1.Installation_Options

2.Architecture_etcd
  Containers_Pods
  Kubeconfig.reformatted

3.Controllers.Batch
4.Controllers.HPA

5.Svc.Services
  - Use MetalLB or alternative (kube-vip?)
5.Svc.Ingress
  - multiple ingress controllers
  - use namespaces for Ingress Controller and for backend services
  - use different ingress controllers
  - TLS via Cert Manager
5.Svc.Mesh.Linkerd
5.Svc.Mesh.Consul

6. Storage
   Volumes    => efs via nfs-provisioner, ebs 
              => full demos with pods, deployments, daemonsets, statefulsets (vol templates)
   ConfigMaps => via API (Python, curl), downward API, stakater/reloader
   Secrets    => via API (Python, curl), downward API, stakater/reloader

9. Security
   NetworkPolicies
   OPA / Kyverno

MISC_SCRIPTS
TOSORT

# LABS:

- see here for descriptions of labs
  - https://docs.google.com/document/d/1PzOltUNk1r4AMSjuPY78N5Kf5DKzwE2hSGrmysMWIFo/edit#bookmark=id.biopnvz0u66p

# Volumes:

emptyDir: as is ?
hostPath: as is ? (other types of simple volume ?)

PV/PVC as is ?
PV/PVC with storageClass as is ?
Show use of PV w/o and PVC with storageClass - no match
Show use of PV:claimRef (sets up for a specific PVC in a namespace)
Show use of reclaimPolicy - other Parameters

nfs? nfs dynamic provisioned ?

GKE + GCE PersistentDisk => ON a 2+ node cluster
EKS + ??
AKS + AzureDisk

PV/PVC + Deployment => see multiple Pods using same Volume
PV/PVC + StatefulSet => see multiple Pods using same Volume
   ==> Do these with hostPath, NFS, other ?  
   ==> Do on GKE/GCEPD, EKS/EFS?, AKS/AzDisk

Full PV/PVC + StatefulSet, multi-node, synced DB w. ConfigMap + Secrets :)


# Ingress + TLS:

https://devopscube.com/configure-ingress-tls-kubernetes/

# Other Service / Betworking

- https://medium.com/@kyralak/accessing-kubernetes-services-without-ingress-nodeport-or-loadbalancer-de6061b42d72

- https://medium.com/google-cloud/understanding-kubernetes-networking-services-f0cb48e4cc82

- https://maelvls.dev/avoid-gke-lb-with-hostport/

- https://stackoverflow.com/questions/49716618/is-there-a-way-to-not-use-gkes-standard-load-balancer

# VSCode setup + other options:  e.g. theia

- https://www.cloudsavvyit.com/15585/how-to-setup-vs-code-to-be-portable/

- https://blog.flant.com/kui-hybrid-cli-gui-for-kubernetes

# Resources

- https://fairwinds.medium.com/how-to-set-the-right-kubernetes-resource-limits-f1644394cf71


### Lots of lab/demo ideas here

https://docs.google.com/document/d/18QRUPCWZ18wneYbyEjCiTg16xdv66npRBfqvaNIhG9M/edit#

### My labs as of 2022-Feb-22:
- K8S-1.22.7_Lab1_Installation-scripted.pdf
- K8S-1.22.7_Lab2_KubernetesIntro.pdf
- K8S-1.22.7_Lab2b_KubernetesUpgrade.pdf
- K8S-1.22.7_Lab3_Controllers.pdf
- K8S-1.22.7_Lab4a_MoreControllers.pdf
- K8S-1.22.7_Lab4b_Upgrades.pdf
- K8S-1.22.7_Lab5a_Services.pdf
- K8S-1.22.7_Lab5b_Ingress.pdf
- K8S-1.22.7_Lab6a_Volumes.pdf
- K8S-1.22.7_Lab6b_ConfigMaps.pdf
- K8S-1.22.7_Lab6c_Secrets.pdf
- K8S-1.22.7_Lab7_Observability.pdf
- K8S-1.22.7_Lab9a_Security.pdf
- K8S-1.22.7_Lab9a_Security_scripted.pdf

#### My Labs - previous notes

Lab-2-KubernetesIntro.pdf
Kubectl install, completion, get/describe nodes, get ns
Get pods, kubectl run, curl pod, describe, get -o yaml, create -f, dry-run
Create deploy, labels, krew install

Lab-3-WorkloadControllers.pdf
Deployments/Replicasets, run -it -- /bin/sh, scale, custom-columns

Lab-4a-More-WorkloadControllers.pdf
Kubectl api-resources, kubectl create [-f], , apply [-f], delete [-f]
DaemonSets, StatefulSets, Jobs/CronJobs

Lab-4b-UpgradingApplications.pdf
Run k8s-scenarios demo (automated or manual)
git clone https://github.com/mjbright/k1spy ~/src/k1spy
git clone https://github.com/mjbright/k8s-scenarios ~/src/k8s-scenarios
Manual: set image, rollout history, undo
Create from yaml manifest to allow repeat with repeat strategy
Deploy a DaemonSet and upgrade (only recreate ??)   ⇐ TO CHECK
Deploy a StatefulSet and upgrade (only ?? recreate ??)   ⇐ TO CHECK
TODO: remove or correct “SET workshop”
TODO: Spelling correct manifest, daeminsets
TODO: full applications - Flask/SQL - Deployments/StatefulSets (with DB sync) 


### LFS458 Labs


### LFD459 Labs

# Student demo requests ...

- Securing secrets in k8s
- Knative setup for k8s
- Using Solr in K8
- Full site set up for Temporary sites
- Deployment automation involving : Infrastructure as Code with K8s and CI-CD tools
- Kubernetes for AI/ML space
- replica set and labelling
- Implementation of Kubernetes Networking Model
- Certificates in Kubernetes and its working/internals
- Kubernetes on hybrid cloud
- Kubernetes chaos management



# Tip for vi editing of yaml

Create a ~/.vimrc file as follows:

cat > ~/.vimrc <<EOF
:set noai
:set paste
:syn on
EOF

# Each time vi(m) is started it will set the 
# - noautoindent option
# - paste option to better handle copy/paste
# - enable syntax highlighting (for yaml)
>

# TOOLS:
- https://pastebin.com/ - useful to share commands/output to help students
- tmate: useful to share terminal session (set as default??)
- VScode + (Docker) + Kubernetes extension + RemoteSSH
- Lens https://k8slens.dev/ 
- Portainer https://documentation.portainer.io/v2.0/deploy/ceinstallk8s/ 
- K9s (TUI) https://github.com/derailed/k9s/releases 
- Krew (/tmp/installkrew.sh) https://krew.sigs.k8s.io/ 
- export PATH=~/.krew/bin:$PATH
- Kubectl krew search …
- https://github.com/mjbright/k8s-scenarios/blob/master/scripts/install_krew.sh 


# Installation - creation of new join command

If you need to create a new token / join command:
    kubeadm token create --print-join-command

# Installation - To convert 2nd node to be a worker (if a cp node already):

On the worker:
    Sudo kubeadm reset
    Sudo rm -rf /var/lib/etcd /etc/kubernetes

On the “real” control plane node:
    Obtain the kubeadm join command from the script output: ~/cp.out
     (e.g. grep -A 1 “kubeadm join” ~/cp.out)

On the worker:
    Run the join command (taken from the other node)

# etcd / etcdctl

- First show limited shell in etcd Pod
- Show /etc/kubernetes/manifests/etcd.yaml => certificates
- To install the etcdctl client:
  - TOO OLD:      sudo apt-get install -y etcd-client
  - wget https://github.com/etcd-io/etcd/releases/download/v3.5.2/etcd-v3.5.2-linux-amd64.tar.gz
  - tar xf etcd-v3.5.2-linux-amd64.tar.gz  etcd-v3.5.2-linux-amd64/etcdctl
  - mv etcd-v3.5.2-linux-amd64/etcdctl  bin/
- Create etcdctl alias (replace IP address by control-plane node IP or 127.0.0.1):
  - alias etcdctl='sudo /home/student/bin/etcdctl --cacert=/etc/kubernetes/pki/etcd/server.crt --cert=/etc/kubernetes/pki/etcd/peer.crt --key=/etc/kubernetes/pki/etcd/peer.key --endpoints=https://172.31.3.158:2379'
- Interesting article: show etcd watch: https://learnk8s.io/etcd-kubernetes
- etcdctl member list -w table

# Correcting for Node disk space

Note to self: create larger node disks in future !!!

Problem is Pods being evicted due to Node DiskPressure
kubectl describe node cp | grep DiskPressure
  DiskPressure         True   Thu, 10 Mar 2022 15:47:57 +0000   Wed, 09 Mar 2022 10:09:38 +0000   KubeletHasNoDiskPressure     kubelet has no disk pressure

kubectl describe node kube1-2 | grep DiskPressure
  DiskPressure         False   Thu, 10 Mar 2022 15:47:57 +0000   Wed, 09 Mar 2022 10:09:38 +0000   KubeletHasNoDiskPressure     kubelet has no disk pressure


To fix:  edit file 
Following advice here:
https://stackoverflow.com/questions/64740620/how-to-reduce-the-diskpressure-condition-threshold-of-a-node

sudo vi /var/lib/kubelet/config.yaml
ADD LINES:
evictionHard:
    nodefs.available: 5%


   sudo systemctl restart kubelet

# Helm installation of metrics-server (after linkerd installation):

FIRST: helm uninstall my-metrics-server

helm repo add metrics-server-3 https://kubernetes-sigs.github.io/metrics-server

helm search repo metrics-server-3

helm install my-metrics-server metrics-server-3/metrics-server --version 3.8.2 --set args='{--kubelet-preferred-address-types=InternalIP,--kubelet-insecure-tls}'


