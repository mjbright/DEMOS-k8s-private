#!/usr/bin/env bash

CP_TOKEN=$( sudo kubeadm init phase upload-certs --upload-certs |& tail -1 )
echo $CP_TOKEN

JOIN_WO="sudo $( sudo kubeadm token create --print-join-command )"
echo "JOIN_WO=$JOIN_WO"

JOIN_CP="$JOIN_WO --control-plane --certificate-key $CP_TOKEN"
echo "JOIN_CP=$JOIN_CP "

#kubectl get no -w

