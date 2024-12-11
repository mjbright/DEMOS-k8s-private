
For system roles etc, see: https://kubernetes.io/docs/reference/access-authn-authz/rbac/
Search in page for "system:"

All (cluster)roles:
    kubectl get clusterroles
    kubectl get roles -A

All (cluster)rolebindings:
    kubectl get clusterrolebindings
    kubectl get rolebindings -A

