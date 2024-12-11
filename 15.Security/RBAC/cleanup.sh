
# -- CLEANUP: --------------------------------------------------------------------------------
{
  kubectl delete clusterrole        cluster-read
  kubectl delete clusterrolebinding crb-cluster-read
  kubectl delete clusterrole        cr-reads
  kubectl delete clusterrolebinding crb-cr-reads
  kubectl delete ns joe
  kubectl delete ns jim
  kubectl delete role create-pods
  kubectl delete rolebinding create-pods-jim
  kubectl delete rolebinding create-pods-joe
} 2>/dev/null

