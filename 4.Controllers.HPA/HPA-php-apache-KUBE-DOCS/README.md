
From https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/

Note: Don't need to build image, can just use php-apache.yaml directly which pulls registry.k8s.io/hpa-example

kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10

kubectl get hpa

kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"


watch kubectl  get all

# Observe: after a few minutes

```
NAME                                             REFERENCE               TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/php-apache   Deployment/php-apache   59%/50%   1         10        5          5m38s
```

### Stop load-generator and after a few minutes ... quite a few !!??


```
NAME                                             REFERENCE               TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/php-apache   Deployment/php-apache   0%/50%    1         10        1          5m38s
```




kubectl get hpa




kubectl describe hpa php-apache 
