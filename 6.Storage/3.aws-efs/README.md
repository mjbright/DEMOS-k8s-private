
# WORKING:

- by forcing nodeName to cp (so presumably worker nodes don't have correct iam profile)
  - check if can mount from command-line on worker
  - what's missing from iam profile

# TODO:

- modify yaml to be templates, replace namespace to use

- need usage scenarios: (common to provisioners), 0.usage => pod, deployment, statefulset, ...

- why doesn't showmount work?

- can I just use nfs-provisioner to connect? (as we can just nfs mount) instead of unmaintained efs-provisioner

- add other provisioners
  - EBS?
  - Longhorn
  - OpenEBS (OpenMaya?)
  - Rook

# Based on

https://fisher046.github.io/post/how-to-create-pv-dynamically-on-k8s-with-aws-efs/

Tried using newer image (careful - critical bugs):
- https://quay.io/repository/external_storage/efs-provisioner?tab=tags&tag=latest

Based on retired: https://github.com/kubernetes-retired/external-storage
Deprectaed, replaced by https://github.com/kubernetes-sigs/sig-storage-lib-external-provisioner
- but how to use with EFS? or EBS?

# NOTE WORKING

It seems container created mount point mased on mount-point DNS (see setup.sh MT_DNS)rather than straight DNS

kubectl logs efs-provisioner-54b56587b8-zxjcm
E0604 23:54:36.719685       1 efs-provisioner.go:69]
F0604 23:54:36.720372       1 efs-provisioner.go:76] no mount entry found for fs-0e5bf733ebdffeb1e.efs.us-west-1.amazonaws.com among entries
    overlay:/,
    proc:/proc,
    tmpfs:/dev,
    devpts:/dev/pts,
    mqueue:/dev/mqueue,
    sysfs:/sys,
    tmpfs:/sys/fs/cgroup,
    cgroup:/sys/fs/cgroup/systemd,
    cgroup:/sys/fs/cgroup/cpu,cpuacct,
    cgroup:/sys/fs/cgroup/cpuset,
    cgroup:/sys/fs/cgroup/net_cls,net_prio,
    cgroup:/sys/fs/cgroup/blkio,
    cgroup:/sys/fs/cgroup/memory,
    cgroup:/sys/fs/cgroup/misc,
    cgroup:/sys/fs/cgroup/freezer,
    cgroup:/sys/fs/cgroup/hugetlb,
    cgroup:/sys/fs/cgroup/perf_event,
    cgroup:/sys/fs/cgroup/rdma,
    cgroup:/sys/fs/cgroup/pids,
    cgroup:/sys/fs/cgroup/devices,
    shm:/dev/shm,
    tmpfs:/etc/resolv.conf,
    tmpfs:/etc/hostname,
    tmpfs:/run/.containerenv,
    us-west-1a.fs-0e5bf733ebdffeb1e.efs.us-west-1.amazonaws.com:/pvs:/persistentvolumes,
    /dev/root:/etc/hosts,
    /dev/root:/dev/termination-log,
    tmpfs:/run/secrets/kubernetes.io/serviceaccount,
    proc:/proc/bus,
    proc:/proc/fs,
    proc:/proc/irq,
    proc:/proc/sys,
    proc:/proc/sysrq-trigger,
    tmpfs:/proc/acpi,
    tmpfs:/proc/kcore,
    tmpfs:/proc/keys,
    tmpfs:/proc/timer_list,
    tmpfs:/proc/scsi,
    tmpfs:/sys/firmware,


