
kubectl get nodes --show-labels |
    sed -e 's/[A-z,\-]*.kubernetes.io\/[^,]*//g'  -e 's/ ,/ /'



