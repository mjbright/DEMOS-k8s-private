
# Experiment with etcdctl function

Work through learnk8s article

- https://learnk8s.io/etcd-kubernetes

Build best "command-line" demo, document as optional lab
- With and without Kubernetes

- https://etcd.io/docs/v3.5/
- https://etcd.io/docs/v3.5/integrations/

# What about etcdutl ??

Download etcd tar, ectdutl is included:

Note: etcdctl is for network access
Note: etcdutl is for local access to data
      https://github.com/etcd-io/etcd/blob/main/etcdutl/README.md

```
  tar tf ~/src/k8s-scenarios/ephemeral-containers/etcd-v3.5.2-linux-amd64.tar.gz | grep etcdutl

  etcd-v3.5.2-linux-amd64/etcdutl
  etcd-v3.5.2-linux-amd64/README-etcdutl.md
```

## LATER: etcdutl in etcd Pod ?

Maybe separate container image, pass certs in as secrets ... or do hostPath mount of certs

# Build demos around Python3 etcd bindings

Build best "python3" demo, document as optional lab
- With and without Kubernetes

- https://etcd.io/docs/v3.5/integrations/#python

- https://github.com/kragniz/python-etcd3
- https://python-etcd3.readthedocs.io/en/latest/usage.html

- https://www.dasblinkenlichten.com/python-pieces-working-with-etcd/
- https://python.hotexamples.com/examples/etcdctl/EtcdCtl/-/python-etcdctl-class-examples.html

- https://pypi.org/project/python-etcd/
- https://github.com/jplana/python-etcd

- https://github.com/projectcalico/layer-etcd-proxy/blob/master/lib/etcdctl.py
- https://github.com/charmed-kubernetes/layer-etcd/blob/master/lib/etcdctl.py

- https://www.programcreek.com/python/example/93916/etcd.Client

- https://www.compose.com/articles/building-a-dynamic-configuration-service-with-etcd-and-python/

# Kubernetes watch

https://www.programcreek.com/python/example/111707/kubernetes.watch.Watch


