
kubectl api-resources --verbs=list --namespaced -o name |
  xargs -t -n 1 kubectl get --show-kind --ignore-not-found $*
# e.g. $0 -l <label>=<value> -n <namespace>

