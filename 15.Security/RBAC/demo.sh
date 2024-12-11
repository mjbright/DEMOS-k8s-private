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

# Create user Namespaces, Roles & Role bindings:
ENABLE_PODS_CREATION() {
    DEMO_HEADER "CREATE user namespaces"
    RUN kubectl create ns joe
    RUN kubectl create ns jim

    # STEP_HEADER "Check users can get pods"
    # RUN kubectl -n joe --kubeconfig /home/student/.kube/config.joe get pods
    # RUN kubectl -n jim --kubeconfig /home/student/.kube/config.jim get pods

    DEMO_HEADER "CHECK ACCESS:"  " Check new users can(NOT) create pods"
    RUN kubectl        --kubeconfig /home/student/.kube/config.joe run testp --image alpine --restart Never -- sleep 1
    RUN kubectl        --kubeconfig /home/student/.kube/config.jim run testp --image alpine --restart Never -- sleep 1
    RUN kubectl -n joe --kubeconfig /home/student/.kube/config.joe run testp --image alpine --restart Never -- sleep 1
    RUN kubectl -n jim --kubeconfig /home/student/.kube/config.jim run testp --image alpine --restart Never -- sleep 1
    RUN kubectl -n joe --kubeconfig /home/student/.kube/config.joe get pods
    RUN kubectl -n jim --kubeconfig /home/student/.kube/config.jim get pods

    DEMO_HEADER "ENABLE ACCESS:"  " Allow new users to create pods (only in their own namespace)"
    RUN kubectl -n joe create role create-pods --resource pod,deploy,ds,rs,sts,job,cronjob --verb create,update,delete
    RUN kubectl -n jim create role create-pods --resource pod,deploy,ds,rs,sts,job,cronjob --verb create,update,delete
    RUN kubectl create rolebinding create-pods-jim --role create-pods -n jim --user jim
    RUN kubectl create rolebinding create-pods-joe --role create-pods -n joe --user joe

    # Can now create Pods in respective namespaces:
    DEMO_HEADER "CHECK ACCESS:"  " Check new users can now create pods (in their own namespace)"
    RUN kubectl -n joe --kubeconfig /home/student/.kube/config.joe run testp --image alpine --restart Never -- sleep 1
    RUN kubectl -n joe --kubeconfig /home/student/.kube/config.joe get pods
    RUN kubectl -n jim --kubeconfig /home/student/.kube/config.jim run testp --image alpine --restart Never -- sleep 1
    RUN kubectl -n jim --kubeconfig /home/student/.kube/config.jim get pods

    # Cannot  create Pods in other namespaces:
    DEMO_HEADER "CHECK ACCESS:"  " Check new users can still NOT create pods (in other namespaces)"
    RUN kubectl -n jim --kubeconfig /home/student/.kube/config.joe run testp --image alpine --restart Never -- sleep 1
    RUN kubectl -n joe --kubeconfig /home/student/.kube/config.jim run testp --image alpine --restart Never -- sleep 1
    RUN kubectl        --kubeconfig /home/student/.kube/config.joe run testp --image alpine --restart Never -- sleep 1
    RUN kubectl        --kubeconfig /home/student/.kube/config.jim run testp --image alpine --restart Never -- sleep 1
}

# -- Main: -----------------------------------------------------------------------------------

CLEANUP
CREATE_USERS
echo;echo; echo;echo
ls -al ~/.kube/config.{jim,joe}

ENABLE_NODES
ENABLE_PODS_READ_ALL_NS
ENABLE_PODS_CREATION
exit






## TO CHECK ================================================================================
#kubectl create rolebinding read-pods --role read-pods --user jim -n jim

## TO ADD   ================================================================================
#Groups ....



