#!/usr/bin/env bash

cd $(dirname $0)

echo "Sourcing ../../demos.rc"
source ../../demos.rc

# -- Func: -----------------------------------------------------------------------------------

CLEANUP() {
  ./cleanup.sh
}

# -- Create 2 users (in 2 groups): -----------------------------------------------------------
CREATE_USERS() {
    DEMO_HEADER "CREATE USERS:"  " Creating new 'users' jim & joe"
    ~/src/mjbright.k8s-scenarios/scripts/create_user_kubeconfig.sh jim -g dev
    ~/src/mjbright.k8s-scenarios/scripts/create_user_kubeconfig.sh joe -g admin
}

# -- ENABLE kubectl get nodes: ---------------------------------------------------------------
ENABLE_NODES() {
    DEMO_HEADER "CHECK ACCESS:"  " Check new users can(NOT) get nodes"
    STEP_HEADER "Can jim/joe get nodes? (NO !)"
    RUN kubectl --kubeconfig /home/student/.kube/config.joe get nodes # FAIL !!
    RUN kubectl --kubeconfig /home/student/.kube/config.jim get nodes # FAIL !!
    RUN kubectl --kubeconfig /home/student/.kube/config.joe get pods  # FAIL !!
    RUN kubectl --kubeconfig /home/student/.kube/config.jim get pods  # FAIL !!

    DEMO_HEADER "ENABLE ACCESS:"  " Allow new users to get nodes"
    STEP_HEADER "Create cluster-read ClusterRole"
    # Create ClusterRole & ClusterRoleBindings
      RUN kubectl create clusterrole cluster-read --resource node,namespace,persistentvolumes --verb get,watch,list
    
    STEP_HEADER "Create crb-cluster-read ClusterRoleBinding"
    # Note: --user joe,jim treated as "joe,jim" !!
      RUN kubectl create clusterrolebinding crb-cluster-read --clusterrole cluster-read --user joe --user jim
    
    STEP_HEADER "Can jim/joe get nodes? (YES !)"
      RUN kubectl --kubeconfig /home/student/.kube/config.joe get nodes
      RUN kubectl --kubeconfig /home/student/.kube/config.jim get nodes
}
    
# -- ENABLE kubectl get pods: ----------------------------------------------------------------
ENABLE_PODS_READ_ALL_NS() {
    DEMO_HEADER "CHECK ACCESS:"  " Check new users can(NOT) get pods"

    RUN kubectl --kubeconfig /home/student/.kube/config.joe get pods
    RUN kubectl --kubeconfig /home/student/.kube/config.jim get pods

    DEMO_HEADER "ENABLE ACCESS:"  " Allow new users to get pods (across all namespaces)"
    RUN kubectl create clusterrole cr-reads --resource pod,deploy,ds,rs,sts,job,cronjob --verb get,watch,list
    RUN kubectl create clusterrolebinding crb-reads --clusterrole cr-reads --user joe --user jim

    RUN kubectl --kubeconfig /home/student/.kube/config.joe get pods
    RUN kubectl --kubeconfig /home/student/.kube/config.jim get pods
}

# -- Main: -----------------------------------------------------------------------------------

CLEANUP
CREATE_USERS
ls -al ~/.kube/config.{jim,joe}

ENABLE_NODES
ENABLE_PODS_READ_ALL_NS
exit


SECTION1 section1
SECTION2 section2

    STEP_HEADER "Step1:" " Hello world"
    STEP_HEADER "Step2: Hello world"

RUN ls
RUN_PRESS ls


# Create user Namespaces, Roles & Role bindings:
  kubectl create ns joe
  kubectl create ns jim
  kubectl -n joe --kubeconfig /home/student/.kube/config.joe get pods
  kubectl -n jim --kubeconfig /home/student/.kube/config.jim get pods

  kubectl        --kubeconfig /home/student/.kube/config.joe run testp --image alpine --restart Never -- sleep 1
  kubectl        --kubeconfig /home/student/.kube/config.jim run testp --image alpine --restart Never -- sleep 1
  kubectl -n joe --kubeconfig /home/student/.kube/config.joe run testp --image alpine --restart Never -- sleep 1
  kubectl -n jim --kubeconfig /home/student/.kube/config.jim run testp --image alpine --restart Never -- sleep 1

  kubectl -n joe --kubeconfig /home/student/.kube/config.joe get pods
  kubectl -n jim --kubeconfig /home/student/.kube/config.jim get pods

  kubectl -n joe create role create-pods --resource pod,deploy,ds,rs,sts,job,cronjob --verb create,update,delete
  kubectl -n jim create role create-pods --resource pod,deploy,ds,rs,sts,job,cronjob --verb create,update,delete
  kubectl create rolebinding create-pods-jim --role create-pods -n jim --user jim
  kubectl create rolebinding create-pods-joe --role create-pods -n joe --user joe

  # Can now create Pods in respective namespaces:
  kubectl -n joe --kubeconfig /home/student/.kube/config.joe run testp --image alpine --restart Never -- sleep 1
  kubectl -n jim --kubeconfig /home/student/.kube/config.jim run testp --image alpine --restart Never -- sleep 1

  # Cannot  create Pods in other namespaces:
  kubectl -n jim --kubeconfig /home/student/.kube/config.joe run testp --image alpine --restart Never -- sleep 1
  kubectl -n joe --kubeconfig /home/student/.kube/config.jim run testp --image alpine --restart Never -- sleep 1
  kubectl        --kubeconfig /home/student/.kube/config.joe run testp --image alpine --restart Never -- sleep 1
  kubectl        --kubeconfig /home/student/.kube/config.jim run testp --image alpine --restart Never -- sleep 1

## TO CHECK ================================================================================
#kubectl create rolebinding read-pods --role read-pods --user jim -n jim

## TO ADD   ================================================================================
#Groups ....



