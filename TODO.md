
# To add

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
- TBD

### 1.K101
- TBD

### 2.Architecture_etcd
- TBD

### 4.Controllers
- TBD

### 4.Controllers.Batch
- TBD

### 4.Controllers.HPA
- TBD

### 4.Controllers.UPGRADES
- TBD

### 5.Services.Ingress
- TBD

- Helm Chart uses ngingx/php and CertManager: https://github.com/SickHub/charts/tree/main/sickhub/nginx-phpfpm

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

### 10.Security
- TBD

- Admission Controller examples
https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/

- Create PodSecurityStandards demo (difficult to understand config)
https://kubernetes.io/docs/concepts/security/pod-security-standards/
https://stackoverflow.com/questions/72364704/no-matches-for-kind-admissionconfiguration-in-version-apiserver-config-k8s-io

### 12.Scheduling
- TBD

### 14.CRDs
- TBD


### N.Misc
- TBD

### N.Misc.scripts
- TBD

### N.yaml
- TBD

### TOSORT
- TBD

# mkdocs
- DEMO-plans
- LFD459-Hints
- LFS458-Hints
- setup.rc

