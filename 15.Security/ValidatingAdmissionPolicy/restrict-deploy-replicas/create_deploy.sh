# Fail:
kubectl create deploy test10 --image mjbright/k8s-demo:1 --replicas 8

# Works:
# kubectl create deploy test10 --image mjbright/k8s-demo:1 --replicas 4

# How to prevent this ??
# kubectl scale deploy test10 --replicas 10
