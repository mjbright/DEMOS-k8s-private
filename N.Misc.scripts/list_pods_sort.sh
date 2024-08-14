
# kubectl get po -A --sort-by='{.metadata.creationTimestamp}'
# kubectl get po --sort-by=.status.startTime
# kubectl get po --sort-by='{.firstTimestamp}'.
# kubectl get pods --sort-by=.metadata.creationTimestamp 

# reverse order:
# kubectl get po -A --sort-by=.status.startTime | tac

# As kubectl top (metrics-server) --sort-by option is buggy:
# Should work (but doesn't in v1.19): top pod -A --containers --sort-by memory
# Works: kubectl top pod -A | sort --reverse --key 4 --numeric

# For CPU:
# kubectl top pod -A | sort --reverse --key 3 --numeric

kubectl get po --sort-by='{.metadata.creationTimestamp}' $*

