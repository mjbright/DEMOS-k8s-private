
# -- Create 2 users (in 2 groups): -----------------------------------------------------------
  ~/src/mjbright.k8s-scenarios/scripts/create_user_kubeconfig.sh jim -g dev
  ~/src/mjbright.k8s-scenarios/scripts/create_user_kubeconfig.sh joe -g admin

# -- ENABLE kubectl get nodes: ---------------------------------------------------------------
  kubectl --kubeconfig /home/student/.kube/config.joe get nodes # FAIL !!
  kubectl --kubeconfig /home/student/.kube/config.jim get nodes # FAIL !!

  # Create ClusterRole & ClusterRoleBindings
  kubectl create clusterrole cluster-read --resource node,namespace,persistentvolumes --verb get,watch,list

  # Note: --user joe,jim treated as "joe,jim" !!
  kubectl create clusterrolebinding crb-cluster-read --clusterrole cluster-read --user joe --user jim

  kubectl --kubeconfig /home/student/.kube/config.joe get nodes
  kubectl --kubeconfig /home/student/.kube/config.jim get nodes

# -- ENABLE kubectl get pods: ----------------------------------------------------------------
  kubectl --kubeconfig /home/student/.kube/config.joe get pods # FAIL !!
  kubectl --kubeconfig /home/student/.kube/config.jim get pods # FAIL !!

  kubectl create clusterrole cr-reads --resource pod,deploy,ds,rs,sts,job,cronjob --verb get,watch,list
  kubectl create clusterrolebinding crb-reads --clusterrole cr-reads --user joe --user jim

  kubectl --kubeconfig /home/student/.kube/config.joe get pods
  kubectl --kubeconfig /home/student/.kube/config.jim get pods

# Create user Namespaces, Roles & Role bindings:
  kubectl create ns joe
  kubectl create ns jim
  kubectl -n joe --kubeconfig /home/student/.kube/config.joe get pods
  kubectl -n jim --kubeconfig /home/student/.kube/config.jim get pods

  kubectl        --kubeconfig /home/student/.kube/config.joe run pod alpine --rm -- sleep 1
  kubectl        --kubeconfig /home/student/.kube/config.jim run pod alpine --rm -- sleep 1
  kubectl -n joe --kubeconfig /home/student/.kube/config.joe run pod alpine --rm -- sleep 1
  kubectl -n jim --kubeconfig /home/student/.kube/config.jim run pod alpine --rm -- sleep 1

  kubectl -n joe --kubeconfig /home/student/.kube/config.joe get pods
  kubectl -n jim --kubeconfig /home/student/.kube/config.jim get pods

  #kubectl create role create-pods --resource pods --verb create,update,delete 
  #kubectl create role create-pods --resource pods --verb create,update,delete
  kubectl create role create-pods --resource pod,deploy,ds,rs,sts,job,cronjob --verb create,update,delete
  kubectl create rolebinding create-pods-jim --role create-pods -n jim --user jim
  kubectl create rolebinding create-pods-joe --role create-pods -n joe --user joe

  # Can now create Pods in respective namespaces:
  kubectl -n joe --kubeconfig /home/student/.kube/config.joe run pod alpine --rm -- sleep 1
  kubectl -n jim --kubeconfig /home/student/.kube/config.jim run pod alpine --rm -- sleep 1

  # Cannot  create Pods in other namespaces:
  kubectl -n jim --kubeconfig /home/student/.kube/config.joe run pod alpine --rm -- sleep 1
  kubectl -n joe --kubeconfig /home/student/.kube/config.jim run pod alpine --rm -- sleep 1
  kubectl        --kubeconfig /home/student/.kube/config.joe run pod alpine --rm -- sleep 1
  kubectl        --kubeconfig /home/student/.kube/config.jim run pod alpine --rm -- sleep 1

## TO CHECK ================================================================================
#kubectl create rolebinding read-pods --role read-pods --user jim -n jim

## TO ADD   ================================================================================
#Groups ....



