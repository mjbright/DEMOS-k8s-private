
# Ephemeral containers

ISOLATED_POD=web-xx-yy
DEBUG_CONTAINER=zzzz

1. Isolate Pod
    kubectl label pod $ISOLATED_POD app=debug-web --overwrite

2. Describe Pod - observe "Containers:" section (not "EphemeralContainers:")
  kubectl describe pod $ISOLATED_POD | less

3. Launch debug container
    kubectl debug --image alpine $ISOLATED_POD --target=k8s-demo -it -- sh

4. Describe Pod - observe "Containers:" section and also "EphemeralContainers:"
  kubectl describe pod $ISOLATED_POD | less

5. Exec into Pod
  DEBUG_CONTAINER=$( kubectl get pods $ISOLATED_POD -o jsonpath='{.spec.ephemeralContainers[0].name}' )

  kubectl exec -it $ISOLATED_POD -c $DEBUG_CONTAINER -- sh
  $ wget -qO - 127.0.0.1:80        # Can access app (same network namespace)
  $ ps aux                         # Can see app (same PID namespace)
  $ cd /proc/1/root/app/static/img # Can access app filesystem
  $ cp docker_yellow.txt kubernetes.blue.txt # Corrupt kubernetes asciitext image
  $ wget -qO - 127.0.0.1:80        # Webserver output now shows yellow Docker
  $ exit
  
6. Describe Pod - observe "Ephemeral Containers" marked as terminated
  kubectl describe pod $ISOLATED_POD | less

7. Observe debug container log:
  kubectl logs $ISOLATED_POD -c  $DEBUG_CONTAINER


