
# Release related demos

- Start with Kubernetes 1.31 features
- Then move forward/backward ...
- Use this as
  - a learning exercise
  - to make my notes on each release
  - to create demos to integrate in specific modules below

# To add

- Plans per module/chapter below
- More yaml examples
- yaml validators, e.g.
  - https://github.com/yannh/kubeconform
  - https://validkube.com/ ( https://github.com/komodorio/validkube )
    - very interesting as online & includes trivy, polaris, kubescape ...
- kubectl get -o examples (and some piping into jq and/or python)
- json patch examples

### Simple kubectl get -o examples:
- kubectl get pods -n kube-system cilium-86prj -o jsonpath='{.spec.initContainers[*].name}'; echo
- kubectl get pods -n kube-system cilium-86prj -o jsonpath='{.spec.containers[*].name}'; echo

### To review/merge demos into mjbright/k8s-scenarios

# Repertory demos with notes


### 0.Docker
- TBD: create some simple & more complex builds
- TBD: use some of my container-images repo as examples ??

### 1.K101
- TBD: federator project?
- TBD: google micro-services
- TBD: base demos of Pod, shareProcessNamespace, ...
- TBD: Cloud Kubernetes: GKE, AKS, EKS, OKE, ...
- TBD: Other tooling: k0s, k3s, rancher, ...

### 1b.Kubernetes Installation
- TBD: scripted demo (for LFS458) - group containerd, kube-package steps
- TBD: scripted demo (for LFD459) - group containerd, kube-package steps

### 2.Architecture_etcd, platform upgrades
- TBD: /etc/kubernetes/manifests, systemd

### 4.Controllers
- TBD: example manifests for each controller type - share in mjbright/k8s-scenarios

### 4.Controllers.Batch
- TBD: example manifests for each controller type - share in mjbright/k8s-scenarios

### 4.Controllers.HPA
- TBD: example manifests for each controller type - share in mjbright/k8s-scenarios

### 4.Controllers.UPGRADES
- TBD: RollingUpgrades demo in mjbright/k8s-scenarios

### 5.Services.Services
- TBD: Scripted creation of deployments & services
- TBD: Scripted demo of iptables/endpoints
- TBD: Scripted demo of MetalLB or kube-vip setup for LoadBalancers
- TBD: GKE + LoadBalancer

### 5.Services.Ingress
- TBD

- Helm Chart uses ngingx/php and CertManager: https://github.com/SickHub/charts/tree/main/sickhub/nginx-phpfpm

- Alternate Ingress Controllers

- More Ingress rules

### 5.Services.Mesh.Linkerd
- TBD

### 5.Services.Services
- TBD

### 6.Storage
- TBD

- Interesting idea https://github.com/SickHub/charts/tree/main/sickhub/cronjobs
  - uses ConfigMaps to store scripts for a CronJob

- Create Secrets examples
https://blog.gitguardian.com/the-runtime-secrets-security-gap/

### 7.Helm
- TBD

- LOOK AT: https://github.com/SickHub/charts
- Create my own helm charts on github

### 7b.Kustomize
- TBD

### 12.Scheduling
- Improve example (nice demo of redis spread, flask colocation)
  - Use simpler region/zones
  - align with slides
- Look at jruels: anything to take from this ?

- Scripted demo of
  - taints
  - tolerations
  - nodeName
  - nodeSelector
  - nodeAffinity
  - podAffinity/AntiAffinity

### 14.CRDs
- TBD: Adapt my slides as per "14.CRDs/crds.k8s.io/" example
  - copy/modify example to something less "shirty" !


### 15.Security
- TBD: Develop RBAC_users_groups.md in DEMOS-k8s-private/10.Security/RBAC
  - include creation of new user (compare with methods of LFD459/LFS458)
  - show get nodes, get pods: no permissions
  - add cluster "read" permissions
  - show get nodes: OK
  - add pod "read" permissions
  - show get pods: OK
  - show create deploy: no permissions
  - add deployment,other-controllers "read/write" permissions
  - show create deploy: OK
  - show existing cluster roles, rolebindings
  - create user with "system" cluster roles
  - create serviceaccount
  - assign roles to serviceaccount
  - create pod in serviceaccount
  - show api access

### Admission Controller

Progressive examples ...

- (inbuilt) Admission Controller examples
https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/

- Create PodSecurityStandards demo (difficult to understand config)
https://kubernetes.io/docs/concepts/security/pod-security-standards/
https://stackoverflow.com/questions/72364704/no-matches-for-kind-admissionconfiguration-in-version-apiserver-config-k8s-io

- VAP examples

- external agent/webhook example

### 16.HA

Fully script up my own demo
- of LFS458 HA ( plus kube-vip )
- own version using nginx ( plus kube-vip )

### N.Misc
- TBD: krew, k9s, konform

### N.Misc.scripts
- TBD

### N.yaml
- TBD: Build up set of example manifests => put under mjbright/k8s-scenarios
  - look at existing examples

### TOSORT
- TBD

# mkdocs
- DEMO-plans
- LFD459-Hints
- LFS458-Hints
- setup.rc

