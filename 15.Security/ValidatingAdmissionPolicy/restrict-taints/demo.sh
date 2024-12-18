#!/usr/bin/env bash

cd $(dirname $0)

echo "Sourcing ../../../demos.rc"
source ../../../demos.rc

CN=dave
OU=junior-admin
KC="$HOME/.kube/config.$CN"
KC_OPT="--kubeconfig $KC"

set -x; mv ~/.kube/config.$CN ~/.kube/config.$CN.bak; set +x

CREATE_USER_GROUP() {
    STEP_HEADER "Creating user '$CN' in group '$OU':"
    set -x
    ~/src/mjbright.DEMOS-k8s-private/scripts/create_user_kubeconfig.sh $CN -g $OU
    set +x

    # Silently delete testp-taint Pod is it exists already:
    kubectl delete pod run testp-taint >/dev/null 2>&1
    # Silently delete clusterrolebinding if it exists already:
    kubectl delete clusterrolebinding junior-admin >/dev/null 2>&1

    #echo "Dave can't yet do anything:"
    #kubectl $KC_OPT get nodes
    STEP_HEADER "Verifying user basic abilities (DENIED) ..."
    RUN kubectl $KC_OPT get nodes
    RUN kubectl $KC_OPT run testp-taint --image alpine --restart Never -- sleep 1
    RUN kubectl $KC_OPT get pods
    
    echo "Give '$OU' group 'cluster-admin' permissions:"
    RUN kubectl create clusterrolebinding $OU --clusterrole cluster-admin --group $OU
}

DEMO_HEADER "CREATE user/group user(CN)=$CN group(OU)=$OU"
if [ -f $KC ]; then
    echo -e "\nKubeconfig file $KC already exists - skipping user/group creation"
    ls -al $KC
else
    CREATE_USER_GROUP
fi

    # STEP_HEADER "Check users can get pods"

# Verify user basic abilities
STEP_HEADER "Verifying user basic abilities (ALLOWED) ..."
RUN kubectl $KC_OPT get nodes
RUN kubectl $KC_OPT run testp-taint --image alpine --restart Never -- sleep 1
RUN kubectl $KC_OPT get pods

DEMO_HEADER "Applying 'taint' denial policy for group $OU"
# Silently delete policy if it exists already:
kubectl delete -f policy.yaml >/dev/null 2>&1
# Silently remove taint if it exists already:
kubectl taint node cp KEY- >/dev/null 2>&1

echo; echo -e "Verifying 'junior-admin's ${YELLOW}CAN${NORMAL} apply taints ${YELLOW}BEFORE${NORMAL} applying the policy ..."
RUN kubectl $KC_OPT taint node cp KEY=VALUE:NoSchedule
set -x; kubectl $KC_OPT describe node cp | grep Taints:; set +x
RUN kubectl $KC_OPT taint node cp KEY-
set -x; kubectl $KC_OPT describe node cp | grep Taints:; set +x

STEP_HEADER "Applying the policy:"
RUN kubectl apply -f policy.yaml
echo; echo -e "Verifying 'junior-admin's ${YELLOW}CAN${NORMAL} NO LONGER apply taints ${YELLOW}after${NORMAL} applying the policy ..."
RUN kubectl $KC_OPT taint node cp KEY=VALUE:NoSchedule
set -x; kubectl $KC_OPT describe node cp | grep Taints:; set +x
#RUN kubectl taint node cp KEY-

# Silently delete testp-taint Pod is it exists already:
kubectl delete pod run testp-taint >/dev/null 2>&1


# kubectl taint node cp KEY=VALUE:NoSchedule --dry-run=client -o yaml | grep -A10 -i spec:
# spec:
#   podCIDR: 192.168.0.0/24
#   podCIDRs:
#   - 192.168.0.0/24
#   taints:
#   - effect: NoSchedule
#     key: KEY
#     value: VALUE

