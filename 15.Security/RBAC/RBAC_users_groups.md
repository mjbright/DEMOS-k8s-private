
# Create 2 users (in 2 groups):

  ~/src/mjbright.k8s-scenarios/scripts/create_user_kubeconfig.sh jim -g dev
  ~/src/mjbright.k8s-scenarios/scripts/create_user_kubeconfig.sh joe -g admin

# Fail to get Nodes:
  kubectl --kubeconfig /home/student/.kube/config.joe get nodes
  kubectl --kubeconfig /home/student/.kube/config.jim get nodes

# Create ClusterRole & ClusterRoleBindings

# kubectl delete clusterrolebinding crb-cluster-read
# kubectl delete clusterrole        cluster-read

kubectl create clusterrole cluster-read --resource node,namespace,persistentvolumes --verb get,watch,list

# Note: --user joe,jim treated as "joe,jim" !!
kubectl create clusterrolebinding crb-cluster-read --clusterrole cluster-read --user joe --user jim

# Test get Nodes:

kubectl --kubeconfig /home/student/.kube/config.joe get nodes
kubectl --kubeconfig /home/student/.kube/config.jim get nodes



## TO CHECK ================================================================================

# Create Roles & Role bindings:

kubectl create role read-pods     --resource pods --verb get,watch,list -n joe
kubectl create role read-pods     --resource pods --verb get,watch,list -n jim

kubectl create rolebinding read-pods --role read-pods --user jim -n jim

## TO ADD   ================================================================================

Groups ....



