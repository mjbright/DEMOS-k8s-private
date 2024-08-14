
# multi-object YAML file:

  kubectl get all
  kubectl apply -f multi_object.yaml 
  kubectl get   -f multi_object.yaml 
  kubectl get   -f multi_object.yaml  -A -o wide

  mkdir multi-object-dir
  kubectl create ns test2 --dry-run=client -o json > multi-object-dir/ns_test2.json
  cp -a testpod2.yaml multi-object-dir/
  cp -a deploy_web.yaml multi-object-dir/
  kubectl expose deploy web --port 80 --dry-run=client -o yaml > multi-object-dir/service_web.yaml

  EDIT => namespace: test2 for all

  kubectl apply -f multi-object-dir/
  kubectl get   -f multi-object-dir/
  kubectl get   -f multi-object-dir/ -A
  kubectl get   -f multi-object-dir/ -A -o wide

  kubectl delete -f multi-object-dir/ -A -o wide
  kubectl get   -f multi-object-dir/ -A -o wide
  kubectl apply -f multi-object-dir/
  kubectl get   -f multi-object-dir/ -A -o wide

# Use of apply in a pipeline:
  kubectl get pods --show-labels 
  kubectl get pod testpod2 -o yaml | sed 's/was-here/is-king/' | kubectl apply -f -
  kubectl get pods --show-labels 
  kubectl get pod testpod2 -o yaml | sed 's/is-king/was-here/' | kubectl apply -f -
  kubectl get pods --show-labels 

# initContainers:
  kubectl logs -n test2 init-cont -c init-1
  kubectl logs -n test2 init-cont -c init-2

  kubectl logs -n test2 init-cont 

  kubectl logs -n test2 init-cont -c testpod2-1
  kubectl logs -n test2 init-cont -c testpod2-2

# ShareProcessNamespace:


  kubectl -n test2 exec -it testpod2 -- sh
  kubectl -n test2 exec -it testpod2 -c testpod2-2 -- sh
  # ps aux

  kubectl -n test2 exec -it testpod3 -- sh
  kubectl -n test2 exec -it testpod3 -c testpod3-2 -- sh
  # ps aux


