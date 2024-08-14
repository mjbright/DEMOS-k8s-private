
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

### 5.Services.Mesh.Linkerd
- TBD

### 5.Services.Services
- TBD

### 6.Storage
- TBD

### 7.Helm
- TBD

### 7b.Kustomize
- TBD

### 10.Security
- TBD

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

