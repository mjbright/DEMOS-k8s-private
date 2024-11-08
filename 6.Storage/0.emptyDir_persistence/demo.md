
# WITHOUT emptyDir show that after container restart, /var/log/starts.log content is LOST:
  kubectl apply -f testpod_wo_emptydir.yaml 
  kubectl exec -it testpod  -- cat /var/log/starts.log
  kubectl exec -it testpod  -- cat /var/log/starts.log
  kubectl exec -it testpod  -- cat /var/log/starts.log
  kubectl exec -it testpod  -- cat /var/log/starts.log
  kubectl exec -it testpod  -- cat /var/log/starts.log
  kubectl exec -it testpod  -- cat /var/log/starts.log
  kubectl delete -f testpod_wo_emptydir.yaml 


# WITH emptyDir show that after container restart, /var/log/starts.log content is APPENDED:
  kubectl apply -f testpod_emptydir.yaml 
  kubectl exec -it testpod  -- cat /var/log/starts.log
  kubectl exec -it testpod  -- cat /var/log/starts.log
  kubectl exec -it testpod  -- cat /var/log/starts.log
  kubectl exec -it testpod  -- cat /var/log/starts.log
  kubectl exec -it testpod  -- cat /var/log/starts.log
  kubectl exec -it testpod  -- cat /var/log/starts.log
  kubectl delete -f testpod_emptydir.yaml 



